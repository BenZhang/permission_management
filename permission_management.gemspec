# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'permission_management/version'

Gem::Specification.new do |spec|
  spec.name          = "permission_management"
  spec.version       = PermissionManagement::VERSION
  spec.authors       = ["Ben Zhang"]
  spec.email         = ["bzbnhang@gmail.com"]
  spec.summary       = %q{Permission management.}
  spec.description   = %q{Inspired by Rackspace permission management system.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"

  spec.add_dependency 'nested_form'
end
