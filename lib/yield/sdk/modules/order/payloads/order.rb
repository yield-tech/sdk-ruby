# frozen_string_literal: true

require "date"

require_relative "../../../types/money"
require_relative "../../../utils"
require_relative "order_customer_info"
require_relative "order_status"

module Yield
  module SDK
    module Order
      class Order < Data.define(:id, :order_number, :status, :customer, :date, :total_amount, :note, :payment_link, :creation_time)
        def self.from_payload(payload)
          new(
            id: Utils.assert_string(payload[:id]),
            order_number: Utils.assert_string(payload[:order_number]),
            status: Utils.assert_variant(OrderStatus::ALL, payload[:status]),
            customer: payload[:customer].nil? ? nil : OrderCustomerInfo.from_payload(Utils.assert_hash(payload[:customer])),
            date: Date.parse(Utils.assert_string(payload[:date])),
            total_amount: Money.from_payload(Utils.assert_string(payload[:total_amount])),
            note: payload[:note].nil? ? nil : Utils.assert_string(payload[:note]),
            payment_link: payload[:payment_link].nil? ? nil : Utils.assert_string(payload[:payment_link]),
            creation_time: Time.parse(Utils.assert_string(payload[:creation_time]))
          )
        end
      end
    end
  end
end
