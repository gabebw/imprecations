# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "imprecations/version"

Gem::Specification.new do |s|
  s.name        = "imprecations"
  s.version     = Imprecations::VERSION
  s.authors     = ["Gabe Berke-Williams"]
  s.email       = ["gabe@thoughtbot.com"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "imprecations"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec', '~> 2.6.0')
end