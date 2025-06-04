# frozen_string_literal: true

require_relative "page"

module Yield
  module SDK
    class CursorPayload
      def self.build(cursor)
        if cursor.is_a?(String)
          cursor
        elsif cursor.is_a?(Page)
          cursor.last&.id
        else
          cursor.id
        end
      end
    end
  end
end
