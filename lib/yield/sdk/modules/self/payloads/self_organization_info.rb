# frozen_string_literal: true

require_relative "../../../utils/type_utils"

module Yield
  module SDK
    module Self
      SelfOrganizationInfo = Data.define(
        :id,
        :registered_name,
        :trade_name,
      ) do
        def self.from_payload(payload)
          new(
            id: TypeUtils.expect_string(payload[:id]),
            registered_name: TypeUtils.expect_string(payload[:registered_name]),
            trade_name: payload[:trade_name].nil? ? nil : TypeUtils.expect_string(payload[:trade_name]),
          )
        end
      end
    end
  end
end
