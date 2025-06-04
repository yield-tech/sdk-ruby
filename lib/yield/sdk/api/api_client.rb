# frozen_string_literal: true

require "base64"
require "json"
require "faraday"
require "openssl"
require "time"
require "uri"

require_relative "../utils/type_utils"
require_relative "../version"
require_relative "api_result"

module Yield
  module SDK
    module API
      class Client
        def initialize(api_key, base_url: nil, conn: nil)
          @base_url = base_url || "https://integrate.withyield.com/api/v1"
          @api_key_token, @api_key_hmac_key = Client.extract_api_key(api_key)
          @conn = conn || Faraday.new
          @client_version = SDK.client_version
        end

        def self.extract_api_key(key)
          # "$" is the old separator, supported for backwards compatibility
          key_parts = key.gsub("$", ":").split(":")
          raise ArgumentError, "Invalid Yield API key" if key_parts.length != 3

          token = "#{key_parts[0]}$#{key_parts[1]}"
          hmac_key = Base64.urlsafe_decode64(key_parts[2])
          [token, hmac_key]
        end

        def self.build_signature(hmac_key, timestamp, path, body = nil)
          parts = body.nil? ? [timestamp, path] : [timestamp, path, body]
          message = parts.join("\n")
          sig_bytes = OpenSSL::HMAC.digest("sha512", hmac_key, message)
          Base64.urlsafe_encode64(sig_bytes, padding: false)
        end

        def self.process_response(response, &from_payload_block)
          status_code = response.status
          request_id = response["X-Request-Id"]

          unless response.success?
            error_type = "unexpected_error"
            error_body = nil

            begin
              body = JSON.parse(response.body)
              if body.is_a?(Hash)
                error_type = body["error"] if body["error"].is_a?(String)
                error_body = body
              end
            rescue StandardError
              # ignore
            end

            return Result.failure(status_code, request_id, error_type, error_body, nil)
          end

          begin
            body = JSON.parse(response.body, symbolize_names: true)
            payload = TypeUtils.expect_record(body)
            data = from_payload_block.call(payload)
          rescue StandardError => e
            return Result.failure(status_code, request_id, "invalid_response", nil, e)
          end

          Result.success(status_code, request_id, data)
        end

        def run_query(path, params = nil)
          full_path = path
          unless params.nil?
            # Faraday sorts query parameters by default,
            # so we need to sort it as well for the signature to match.
            # We can disable this globally, but that may be undesirable for some users.
            # See: https://lostisland.github.io/faraday/#/customization/index?id=order-of-parameters
            params = params.compact.to_a.sort_by! { |k, _v| k }
            query_string = URI.encode_www_form(params)
            full_path += "?#{query_string}" unless query_string.empty?
          end

          call_endpoint(:get, full_path, nil)
        end

        def run_command(path, payload)
          call_endpoint(:post, path, payload)
        end

        private

        def call_endpoint(method, path, payload)
          headers = { "X-Yield-Client" => @client_version }

          body = payload&.to_json
          headers["Content-Type"] = "application/json" if body

          timestamp = Time.now.utc.iso8601
          signature = Client.build_signature(@api_key_hmac_key, timestamp, path, body)
          headers["Authorization"] = "Yield-Sig #{@api_key_token}$#{timestamp}$#{signature}"

          @conn.run_request(method, @base_url + path, body, headers)
        end
      end
    end
  end
end
