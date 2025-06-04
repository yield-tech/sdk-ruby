# frozen_string_literal: true

require "uri"

require_relative "../../api/api_client"
require_relative "../../types/page"
require_relative "payloads/customer_row"
require_relative "payloads/customer_list_payload"

module Yield
  module SDK
    module Customer
      class BaseClient
        def initialize(api_client)
          @api = api_client
        end

        def list(params = nil)
          payload = params.nil? ? nil : CustomerListPayload.build(params)
          response = @api.run_query("/customer/list", payload)

          API::Client.process_response(response, &Page.build_with(&CustomerRow.method(:from_payload)))
        end
      end
    end
  end
end
