# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_jquery_autocomplete/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_jquery_autocomplete"
  spec.version       = RailsJQueryAutocomplete::VERSION
  spec.authors       = ["David Padilla"]
  spec.email         = ["david@crowdint.com"]
  spec.description   = %q{A quick and easy way to use jQuery's autocomplete with Rails.}
  spec.summary       = %q{A quick and easy way to use jQuery's autocomplete with Rails.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "actionpack"
  spec.add_dependency "railties"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rr"
end
