# frozen_string_literal: true

module Yield
  module SDK
    class MoneyPayload
      def self.build(money)
        return money if money.is_a?(String)

        "#{money.currency_code} #{money.value.to_s("F")}"
      end
    end
  end
end
