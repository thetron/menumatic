# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "menumatic/version"

Gem::Specification.new do |s|
  s.name        = "menumatic"
  s.version     = Menumatic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicholas Bruning"]
  s.email       = ["nicholas@bruning.com.au"]
  s.homepage    = "http://github.com/thetron/menumatic"
  s.summary     = %q{Menumatic is a Rails 3 gem which simplifies building complex website navigation}
  s.description = %q{Menumatic is a Rails 3 gem which simplifies the development of complex website navigation, producing semantic, usable navigation menus.}

  s.rubyforge_project = "menumatic"

  s.add_dependency 'rails', '> 3.0.0'

  s.add_development_dependency 'rspec', '~> 2.1.0'
  s.add_development_dependency 'rails', '~> 3.0.0'
  s.add_development_dependency 'capybara'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
