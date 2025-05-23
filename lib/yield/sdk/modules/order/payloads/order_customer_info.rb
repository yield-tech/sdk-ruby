# frozen_string_literal: true

require_relative "../../../utils"

module Yield
  module SDK
    module Order
      class OrderCustomerInfo < Data.define(:id, :registered_name, :trade_name)
        def self.from_payload(payload)
          new(
            id: Utils.assert_string(payload[:id]),
            registered_name: Utils.assert_string(payload[:registered_name]),
            trade_name: payload[:trade_name].nil? ? nil : Utils.assert_string(payload[:trade_name])
          )
        end
      end
    end
  end
end
