# frozen_string_literal: true

module Yield
  module SDK
    module Utils
      module_function

      def assert_boolean(data)
        raise ArgumentError, "Expected Boolean, got #{data.class}" unless data == true || data == false
        data
      end

      def assert_integer(data)
        raise ArgumentError, "Expected Integer, got #{data.class}" unless data.is_a?(Integer)
        data
      end

      def assert_string(data)
        raise ArgumentError, "Expected String, got #{data.class}" unless data.is_a?(String)
        data
      end

      def self.assert_variant(variants, data)
        raise ArgumentError, "Expected String, got #{data.class}" unless data.is_a?(String)
        symbol = data.downcase.to_sym
        raise ArgumentError, "Invalid variant: \"#{data}\"" unless variants.include?(symbol)
        symbol
      end

      def self.assert_hash(data)
        raise ArgumentError, "Expected Hash, got #{data.class}" unless data.is_a?(Hash)
        data
      end
    end
  end
end
