# frozen_string_literal: true

require_relative "api_error"
require_relative "api_error_details"

module Yield
  module SDK
    module API
      class Result
        attr_reader :status_code
        attr_reader :request_id
        attr_reader :error

        def initialize(status_code:, request_id:, data:, error:)
          @status_code = status_code
          @request_id = request_id
          @data = data
          @error = error
        end

        def ok?
          error.nil?
        end

        def data
          raise Error.new(status_code, request_id, error), cause: error.exception unless error.nil?

          @data
        end

        def self.success(status_code, request_id, data)
          new(status_code: status_code, request_id: request_id, data: data, error: nil)
        end

        def self.failure(status_code, request_id, error_type, error_body, exception)
          error = ErrorDetails.new(error_type, error_body, exception)

          new(status_code: status_code, request_id: request_id, data: nil, error: error)
        end
      end
    end
  end
end
