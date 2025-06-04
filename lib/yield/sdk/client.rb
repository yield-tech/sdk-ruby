# frozen_string_literal: true

require_relative "base_client"
require_relative "modules/customer/customer_client"
require_relative "modules/order/order_client"
require_relative "modules/self/self_client"

module Yield
  module SDK
    class Client
      attr_reader :base

      attr_reader :customer
      attr_reader :order
      attr_reader :self

      def initialize(api_key, base_url: nil, conn: nil)
        @base = BaseClient.new(api_key, base_url: base_url, conn: conn)

        @customer = Customer::Client.new(@base.customer)
        @order = Order::Client.new(@base.order)
        @self = Self::Client.new(@base.self)
      end
    end
  end
end
