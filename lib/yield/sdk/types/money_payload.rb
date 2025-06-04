# frozen_string_literal: true

module Yield
  module SDK
    class MoneyPayload
      def self.build(money)
        if money.is_a?(String)
          money
        elsif money.is_a?(Array)
          "#{money[0]} #{money[1].to_s("F")}"
        else
          "#{money.currency_code} #{money.value.to_s("F")}"
        end
      end
    end
  end
end
