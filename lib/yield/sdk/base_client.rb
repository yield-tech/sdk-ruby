# frozen_string_literal: true

require_relative "api/api_client"
require_relative "modules/customer/customer_base_client"
require_relative "modules/order/order_base_client"
require_relative "modules/self/self_base_client"

module Yield
  module SDK
    class BaseClient
      attr_reader :api

      attr_reader :customer
      attr_reader :self
      attr_reader :order

      def initialize(api_key, base_url: nil, conn: nil)
        @api = API::Client.new(api_key, base_url: base_url, conn: conn)

        @customer = Customer::BaseClient.new(@api)
        @order = Order::BaseClient.new(@api)
        @self = Self::BaseClient.new(@api)
      end
    end
  end
end
