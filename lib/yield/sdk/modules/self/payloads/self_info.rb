# frozen_string_literal: true

require_relative "../../../utils/type_utils"
require_relative "self_organization_info"

module Yield
  module SDK
    module Self
      SelfInfo = Data.define(
        :id,
        :name,
        :organization,
      ) do
        def self.from_payload(payload)
          new(
            id: TypeUtils.expect_string(payload[:id]),
            name: TypeUtils.expect_string(payload[:name]),
            organization: SelfOrganizationInfo.from_payload(TypeUtils.expect_record(payload[:organization])),
          )
        end
      end
    end
  end
end
