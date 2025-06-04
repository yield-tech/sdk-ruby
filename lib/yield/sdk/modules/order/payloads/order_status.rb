# frozen_string_literal: true

module Yield
  module SDK
    module Order
      module OrderStatus
        ALL = %i[pending confirmed fulfilled cancelled].freeze # : Array[:pending | :confirmed | :fulfilled | :cancelled]
      end
    end
  end
end
