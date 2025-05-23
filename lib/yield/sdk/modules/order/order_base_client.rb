# frozen_string_literal: true

require_relative "../../api/api_client"
require_relative "payloads/order"
require_relative "payloads/order_create_payload"

module Yield
  module SDK
    module Order
      class BaseClient
        def initialize(api_client)
          @api = api_client
        end

        def fetch(id)
          response = @api.run_query("/order/fetch/#{id}")

          API::Client.process_response(response, &Order.method(:from_payload))
        end

        def create(params)
          payload = OrderCreatePayload.build(params)
          response = @api.run_command("/order/create", payload)

          API::Client.process_response(response, &Order.method(:from_payload))
        end
      end
    end
  end
end
