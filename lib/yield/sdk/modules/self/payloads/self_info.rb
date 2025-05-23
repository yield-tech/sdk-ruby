# frozen_string_literal: true

require_relative "../../../utils"
require_relative "self_organization_info"

module Yield
  module SDK
    module Self
      class SelfInfo < Data.define(:id, :name, :organization)
        def self.from_payload(payload)
          new(
            id: Utils.assert_string(payload[:id]),
            name: Utils.assert_string(payload[:name]),
            organization: SelfOrganizationInfo.from_payload(Utils.assert_hash(payload[:organization]))
          )
        end
      end
    end
  end
end
