# frozen_string_literal: true

require_relative "lib/yield/sdk/version"

Gem::Specification.new do |spec|
  spec.name = "yield-sdk"
  spec.version = Yield::SDK::VERSION
  spec.summary = "The official Yield SDK for Ruby"
  spec.license = "Apache-2.0"

  spec.author = "Yield"
  spec.homepage = "https://www.paywithyield.com"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 3.2.0"
  spec.add_dependency "faraday", "~> 2.13"
end
