# frozen_string_literal: true

require_relative "../../../types/money_payload"

module Yield
  module SDK
    module Order
      class OrderCreatePayload
        def self.build(params)
          {
            customer_id: params[:customer_id],
            total_amount: MoneyPayload.build(params[:total_amount]),
            note: params[:note]
          }
        end
      end
    end
  end
end
