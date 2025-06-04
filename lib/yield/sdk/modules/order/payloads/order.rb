# frozen_string_literal: true

require "date"

require_relative "../../../types/money"
require_relative "../../../utils/type_utils"
require_relative "order_customer_info"
require_relative "order_status"

module Yield
  module SDK
    module Order
      Order = Data.define(
        :id,
        :order_number,
        :status,
        :customer,
        :date,
        :total_amount,
        :note,
        :payment_link,
        :creation_time,
      ) do
        def self.from_payload(payload)
          new(
            id: TypeUtils.expect_string(payload[:id]),
            order_number: TypeUtils.expect_string(payload[:order_number]),
            status: TypeUtils.expect_variant(OrderStatus::ALL, payload[:status]),
            customer: payload[:customer].nil? ? nil : OrderCustomerInfo.from_payload(TypeUtils.expect_record(payload[:customer])),
            date: TypeUtils.expect_date(TypeUtils.expect_string(payload[:date])),
            total_amount: Money.from_payload(TypeUtils.expect_string(payload[:total_amount])),
            note: payload[:note].nil? ? nil : TypeUtils.expect_string(payload[:note]),
            payment_link: payload[:payment_link].nil? ? nil : TypeUtils.expect_string(payload[:payment_link]),
            creation_time: TypeUtils.expect_time(TypeUtils.expect_string(payload[:creation_time])),
          )
        end
      end
    end
  end
end
