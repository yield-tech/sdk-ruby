# frozen_string_literal: true

require_relative "../../../utils/type_utils"

module Yield
  module SDK
    module Order
      OrderCustomerInfo = Data.define(
        :id,
        :registered_name,
        :trade_name,
        :customer_code,
      ) do
        def self.from_payload(payload)
          new(
            id: TypeUtils.expect_string(payload[:id]),
            registered_name: TypeUtils.expect_string(payload[:registered_name]),
            trade_name: payload[:trade_name].nil? ? nil : TypeUtils.expect_string(payload[:trade_name]),
            customer_code: payload[:customer_code].nil? ? nil : TypeUtils.expect_string(payload[:customer_code]),
          )
        end
      end
    end
  end
end
