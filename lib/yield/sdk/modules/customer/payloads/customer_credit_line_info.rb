# frozen_string_literal: true

require_relative "../../../types/money"
require_relative "../../../utils/type_utils"

module Yield
  module SDK
    module Customer
      CustomerCreditLineInfo = Data.define(
        :credit_limit,
        :amount_available,
      ) do
        def self.from_payload(payload)
          new(
            credit_limit: Money.from_payload(TypeUtils.expect_string(payload[:credit_limit])),
            amount_available: Money.from_payload(TypeUtils.expect_string(payload[:amount_available])),
          )
        end
      end
    end
  end
end
