# frozen_string_literal: true

module Yield
  module SDK
    VERSION = "0.5.1"

    module_function

    def client_version
      runtime_major_version = RUBY_ENGINE_VERSION.match(/^\d+(\.\d+)?/)[0]
      runtime_version = "#{RUBY_ENGINE} #{runtime_major_version}"

      "Yield-SDK-Ruby/#{VERSION} (#{runtime_version})"
    end
  end
end
