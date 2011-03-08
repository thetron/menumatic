# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "menumatic/version"

Gem::Specification.new do |s|
  s.name        = "menumatic"
  s.version     = Menumatic::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nicholas Bruning"]
  s.email       = ["nicholas@bruning.com.au"]
  s.homepage    = ""
  s.summary     = %q{Menumatic is a Rails 3 gem which aims to simplify building complex website navigation}
  s.description = %q{Menumatic is a Rails 3 exclusive gem which aims to take all the fuss and clutter out of developing semantic, usable navigation menus.}

  s.rubyforge_project = "menumatic"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
