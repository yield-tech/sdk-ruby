# frozen_string_literal: true

require_relative "order_base_client"

module Yield
  module SDK
    module Order
      class Client
        def initialize(base_client)
          @base = base_client
        end

        def fetch(id)
          @base.fetch(id).data
        end

        def create(params)
          @base.create(params).data
        end
      end
    end
  end
end
