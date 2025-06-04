# frozen_string_literal: true

require_relative "../../../utils/type_utils"
require_relative "customer_credit_line_info"

module Yield
  module SDK
    module Customer
      CustomerRow = Data.define(
        :id,
        :registered_name,
        :trade_name,
        :customer_code,
        :credit_line,
      ) do
        def self.from_payload(payload)
          new(
            id: TypeUtils.expect_string(payload[:id]),
            registered_name: TypeUtils.expect_string(payload[:registered_name]),
            trade_name: payload[:trade_name].nil? ? nil : TypeUtils.expect_string(payload[:trade_name]),
            customer_code: payload[:customer_code].nil? ? nil : TypeUtils.expect_string(payload[:customer_code]),
            credit_line: payload[:credit_line].nil? ? nil : CustomerCreditLineInfo.from_payload(TypeUtils.expect_record(payload[:credit_line])),
          )
        end
      end
    end
  end
end
