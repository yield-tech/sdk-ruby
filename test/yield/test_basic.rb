# frozen_string_literal: true

require "faraday"
require "test_helper"

module Yield
  class TestBasic < Minitest::Test
    def setup
      @api_key = ENV.fetch("YIELD_API_KEY")
      @base_url = ENV.fetch("YIELD_API_BASE_URL", nil)

      verify_tls_certificates = @base_url.nil? || !@base_url.include?("localhost")
      conn = Faraday.new(ssl: { verify: verify_tls_certificates })

      @client = ::Yield::SDK::Client.new(@api_key, base_url: @base_url, conn: conn)
    end

    def test_connection
      info = @client.self.info

      assert_equal @api_key.split(":")[0], info.id
    end
  end
end
