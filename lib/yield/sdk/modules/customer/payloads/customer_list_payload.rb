# frozen_string_literal: true

require_relative "../../../types/cursor_payload"

module Yield
  module SDK
    module Customer
      class CustomerListPayload
        def self.build(params)
          {
            limit: params[:limit],
            after: params[:after].nil? ? nil : CursorPayload.build(params[:after]),
            customer_code: params[:customer_code],
            extra_system_id: params[:extra_system_id],
          }
        end
      end
    end
  end
end
