# frozen_string_literal: true

require "bigdecimal"

module Yield
  module SDK
    class Money < Data.define(:currency_code, :value)
      def self.from_payload(payload)
        m = payload.match(/^([A-Z]{3}) (-?\d+(?:\.\d+)?)$/)
        raise ArgumentError, "Invalid money: #{payload}" if m.nil?

        new(currency_code: m[1].to_sym, value: BigDecimal(m[2]))
      end
    end
  end
end
