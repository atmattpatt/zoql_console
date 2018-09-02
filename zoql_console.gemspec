# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "zoql_console/version"

Gem::Specification.new do |spec|
  spec.name          = "zoql_console"
  spec.version       = ZoqlConsole::VERSION
  spec.authors       = ["Matthew Patterson"]
  spec.email         = ["atmattpatt@github.com"]

  spec.summary       = "An interactive command line console for using Zuora's ZOQL API."
  spec.homepage      = "https://github.com/atmattpatt/zoql_console"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "bin"
  spec.executables   = %w[zoql]
  spec.require_paths = %w[lib]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "cucumber", "~> 3.1"
  spec.add_development_dependency "rake", "~> 12.3"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "rubocop", "~> 0.58"
  spec.add_development_dependency "rubocop-rspec", "~> 1.29"
  spec.add_development_dependency "vcr", "~> 4.0"
end
