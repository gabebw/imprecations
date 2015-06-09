# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "imprecations/version"

Gem::Specification.new do |s|
  s.name        = "imprecations"
  s.version     = Imprecations::VERSION
  s.authors     = ["Gabe Berke-Williams"]
  s.email       = ["gabebw@gabebw.com"]
  s.homepage    = ""
  s.summary     = %q{Deprecate every single method on a class}
  s.description = %q{Want to see a warning printed every time you call a method? Of course you do.}

  s.rubyforge_project = "imprecations"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 3.2.0'
end
