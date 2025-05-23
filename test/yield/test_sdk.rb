# frozen_string_literal: true

require "faraday"
require "test_helper"

class Yield::TestSDK < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Yield::SDK::VERSION
  end
end
