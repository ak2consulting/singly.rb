# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "singly/version"

Gem::Specification.new do |s|
  s.name        = "singly"
  s.version     = Singly::VERSION
  s.authors     = ["Kristján Pétursson"]
  s.email       = ["kristjan@singly.com"]
  s.homepage    = "https://github.com/Singly/singly.rb"
  s.summary     = %q{The official Ruby client for the Singly API}

  s.rubyforge_project = "singly"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.add_dependency("httparty")
  s.add_development_dependency("rake")
  s.add_development_dependency("rspec")
end
