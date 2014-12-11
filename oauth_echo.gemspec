# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oauth_echo/version'

Gem::Specification.new do |spec|
  spec.name          = "oauth_echo"
  spec.version       = OAuthEcho::VERSION
  spec.authors       = ["kmats"]
  spec.email         = []
  spec.description   = %q{The implement of OAuth Echo}
  spec.summary       = %q{The implement of OAuth Echo}
  spec.homepage      = "https://github.com/kmats/oauth_echo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"
  spec.add_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
