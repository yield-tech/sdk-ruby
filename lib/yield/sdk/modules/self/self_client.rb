# frozen_string_literal: true

require_relative "self_base_client"

module Yield
  module SDK
    module Self
      class Client
        def initialize(base_client)
          @base = base_client
        end

        def info
          @base.info.data
        end
      end
    end
  end
end
