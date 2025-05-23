# frozen_string_literal: true

require "base64"
require "json"
require "faraday"
require "openssl"
require "time"
require "uri"

require_relative "../version"
require_relative "api_result"

module Yield
  module SDK
    module API
      class Client
        def self.process_response(response, &from_payload_block)
          status_code = response.status
          request_id = response["X-Request-Id"]

          if !response.success?
            error_type = "unexpected_error"
            body = nil

            begin
              body = JSON.parse(response.body)
              error_type = body["error"] if body["error"].is_a?(String)
            rescue
              # ignore
            end

            return Result.failure(status_code, request_id, error_type)
          end

          begin
            data = from_payload_block.call(JSON.parse(response.body, symbolize_names: true))
          rescue
            return Result.failure(status_code, request_id, "unexpected_payload")
          end

          Result.success(status_code, request_id, data)
        end

        def initialize(api_key, base_url: nil, faraday_conn: nil)
          @base_url = base_url || "https://integrate.withyield.com/api/v1"

          key_parts = api_key.split("$")
          raise ArgumentError, "Invalid Yield API key" if key_parts.length != 3
          @api_key_token = "#{key_parts[0]}$#{key_parts[1]}"
          @api_key_hmac_key = Base64.urlsafe_decode64(key_parts[2])

          @faraday_conn = faraday_conn || Faraday.new
          @client_version = SDK.client_version
        end

        def run_query(path, params = nil)
          full_path = params.nil? ? path : "#{path}?#{URI.encode_www_form(params)}"
          call_endpoint(:get, full_path, nil)
        end

        def run_command(path, payload)
          call_endpoint(:post, path, payload)
        end

        def build_signature(path, body = nil, now = Time.now)
          timestamp = now.utc.iso8601

          parts = body.nil? ? [timestamp, path] : [timestamp, path, body]
          message = parts.join("\n")

          signature_bytes = OpenSSL::HMAC.digest("sha512", @api_key_hmac_key, message)
          signature_b64 = Base64.urlsafe_encode64(signature_bytes, padding: false)

          "#{@api_key_token}$#{timestamp}$#{signature_b64}"
        end

        private

        def call_endpoint(method, path, payload)
          headers = {"X-Yield-Client" => @client_version}

          body = payload&.to_json
          headers["Content-Type"] = "application/json" if body

          signature = build_signature(path, body)
          headers["Authorization"] = "Yield-Sig #{signature}"

          @faraday_conn.run_request(method, @base_url + path, body, headers)
        end
      end
    end
  end
end
