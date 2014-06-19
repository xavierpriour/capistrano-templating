# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/templating/version'

Gem::Specification.new do |spec|
  spec.name          = "capistrano-templating"
  spec.version       = Capistrano::Templating::VERSION
  spec.authors       = ["Xavier Priour"]
  spec.email         = ["xavier.priour@bubblyware.com"]
  spec.summary       = %q{Capistrano gem to generate files from templates on deployment}
#  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = "https://github.com/xavierpriour/capistrano-templating"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "capistrano", "~> 3"
end
