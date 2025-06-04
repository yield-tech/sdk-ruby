# frozen_string_literal: true

module Yield
  module SDK
    VERSION = "0.7.0"

    module_function

    def client_version
      m = RUBY_ENGINE_VERSION.match(/^\d+(\.\d+)?/)
      runtime_version = m.nil? ? RUBY_ENGINE : "#{RUBY_ENGINE} #{m[0]}"

      "Yield-SDK-Ruby/#{VERSION} (#{runtime_version})"
    end
  end
end
