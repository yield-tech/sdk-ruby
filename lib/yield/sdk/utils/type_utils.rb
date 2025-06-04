# frozen_string_literal: true

require "date"
require "time"

module Yield
  module SDK
    module TypeUtils
      module_function

      def expect_boolean(data)
        raise TypeError, "Expected bool, got #{data.class}" unless data == true || data == false

        data # : bool
      end

      def expect_integer(data)
        raise TypeError, "Expected Integer, got #{data.class}" unless data.is_a?(Integer)

        data
      end

      def expect_string(data)
        raise TypeError, "Expected String, got #{data.class}" unless data.is_a?(String)

        data
      end

      def expect_date(data)
        raise TypeError, "Expected String, got #{data.class}" unless data.is_a?(String)

        m = data.match(/^(\d{4})-(\d{2})-(\d{2})$/)
        raise ArgumentError, "Invalid date: \"#{data}\"" if m.nil?

        Date.new(m[1].to_i, m[2].to_i, m[3].to_i)
      end

      def expect_time(data)
        raise TypeError, "Expected String, got #{data.class}" unless data.is_a?(String)

        Time.strptime(data, "%FT%T.%L%Z")
      end

      def expect_variant(variants, data) # steep:ignore MethodBodyTypeMismatch
        raise TypeError, "Expected String, got #{data.class}" unless data.is_a?(String)

        symbol = data.downcase.to_sym

        raise ArgumentError, "Invalid variant: \"#{data}\"" unless variants.include?(symbol) # steep:ignore ArgumentTypeMismatch

        symbol
      end

      def expect_record(data)
        raise TypeError, "Expected Hash, got #{data.class}" unless data.is_a?(Hash)

        data
      end

      def expect_list(data)
        raise TypeError, "Expected Array, got #{data.class}" unless data.is_a?(Array)

        data
      end

      def expect_record_list(data)
        expect_list(data).map(&method(:expect_record))
      end
    end
  end
end
