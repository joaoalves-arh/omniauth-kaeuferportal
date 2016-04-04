# -*- encoding: utf-8 -*-
require File.expand_path('../lib/omniauth-kaeuferportal/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.3'
  gem.add_dependency 'omniauth-oauth2', '~> 1.4'

  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'simplecov'

  gem.authors       = ["Christoph Rahles"]
  gem.email         = ["christoph.rahles@kaeuferportal.de"]
  gem.description   = %q{Kaeuferportal-OAuth2 strategy for OmniAuth.}
  gem.summary       = %q{Kaeuferportal-OAuth2 strategy for OmniAuth.}
  gem.homepage      = "https://github.com/Beko-Kaeuferportal/omniauth-kaeuferportal"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "omniauth-kaeuferportal"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::Kaeuferportal::VERSION
end
