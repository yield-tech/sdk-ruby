# frozen_string_literal: true

require_relative "../../api/api_client"
require_relative "payloads/self_info"

module Yield
  module SDK
    module Self
      class BaseClient
        def initialize(api_client)
          @api = api_client
        end

        def info
          response = @api.run_query("/self/info")

          API::Client.process_response(response, &SelfInfo.method(:from_payload))
        end
      end
    end
  end
end
