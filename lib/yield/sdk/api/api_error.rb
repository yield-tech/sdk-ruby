# frozen_string_literal: true

require "json"

module Yield
  module SDK
    module API
      class Error < StandardError
        attr_reader :status_code
        attr_reader :request_id
        attr_reader :details

        def initialize(status_code, request_id, error)
          @status_code = status_code
          @request_id = request_id
          @details = error

          error_info = error.type
          if error.type == "validation_error" && !error.body.nil?
            issues = JSON.generate(error.body["issues"])
            error_info = "#{error_info} #{issues}"
          end

          unless error.exception.nil?
            message = JSON.generate(error.exception.message)
            error_info = "#{error_info} #{message}"
          end

          extra_info = [
            "status_code=#{status_code}",
            "request_id=#{request_id || "<none>"}",
          ].join("; ")

          super("Yield API error: #{error_info} [#{extra_info}]")
        end
      end
    end
  end
end
