# frozen_string_literal: true

module Yield
  module SDK
    module API
      class Result < Data.define(:status_code, :request_id, :data, :error)
        def ok?
          error.nil?
        end

        def data
          raise Error, "Yield API error: #{error} [status_code=#{status_code}]" unless ok?
          super
        end

        def self.success(status_code, request_id, data)
          new(status_code:, request_id:, data:, error: nil)
        end

        def self.failure(status_code, request_id, error)
          new(status_code:, request_id:, data: nil, error:)
        end
      end
    end
  end
end
