# frozen_string_literal: true

require_relative "base_client"
require_relative "modules/order/order_client"
require_relative "modules/self/self_client"

module Yield
  module SDK
    class Client
      attr_reader :base

      attr_reader :self
      attr_reader :order

      def initialize(api_key, base_url: nil, faraday_conn: nil)
        @base = BaseClient.new(api_key, base_url:, faraday_conn:)

        @self = Self::Client.new(@base.self)
        @order = Order::Client.new(@base.order)
      end
    end
  end
end
