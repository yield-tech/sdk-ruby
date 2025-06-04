# frozen_string_literal: true

require "bigdecimal"

module Yield
  module SDK
    Money = Data.define(:currency_code, :value) do
      def self.from_payload(payload)
        m = payload.match(/^([A-Z]{3}) (-?\d+(?:\.\d+)?)$/)
        raise ArgumentError, "Invalid money: \"#{payload}\"" if m.nil?

        # Defined for type-checking reasons
        m1 = m[1] # : String
        m2 = m[2] # : String
        new(currency_code: m1.to_sym, value: BigDecimal(m2))
      end
    end
  end
end
