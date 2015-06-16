# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nfedobrasil/version'

Gem::Specification.new do |spec|
  spec.name          = 'nfedobrasil'
  spec.version       = NfedoBrasil::VERSION
  spec.authors       = ['Eduardo Sampaio']
  spec.email         = ['eduardo@sampa.io']
  spec.summary       = %q{Gem to interact with NFEdoBrasil SOAP API.}
  spec.description   = %q{Gem to interact with NFEdoBrasil SOAP API. Enables creation, consultation and import of invoices.}
  spec.homepage      = 'https://github.com/natuelabs/nfedobrasil'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'savon', '~> 2.11.1'

  spec.add_development_dependency 'bundler',   '~>  1.7'
  spec.add_development_dependency 'rake',      '~> 10.0'
  spec.add_development_dependency 'rspec',     '~>  3.2.0'
  spec.add_development_dependency 'simplecov', '~>  0.10'
end
