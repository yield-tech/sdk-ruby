# frozen_string_literal: true

require_relative "customer_base_client"

module Yield
  module SDK
    module Customer
      class Client
        def initialize(base_client)
          @base = base_client
        end

        def list(params = nil)
          @base.list(params).data
        end
      end
    end
  end
end
