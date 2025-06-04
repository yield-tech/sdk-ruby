# frozen_string_literal: true

require_relative "../utils/type_utils"

module Yield
  module SDK
    class Page
      include Enumerable

      attr_accessor :has_more

      def initialize(items:, has_more:)
        @items = items
        @has_more = has_more
      end

      def self.build_with(&from_payload_block)
        lambda { |payload|
          Page.new(
            items: TypeUtils.expect_record_list(payload[:items]).map(&from_payload_block),
            has_more: TypeUtils.expect_boolean(payload[:has_more]),
          )
        }
      end

      def to_a
        @items.dup
      end

      def size
        @items.size
      end

      def length
        size
      end

      def [](index)
        @items[index]
      end

      def last
        @items.last
      end

      def each(&block)
        @items.each(&block)
      end
    end
  end
end
