# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "imprecations/version"

Gem::Specification.new do |s|
  s.name        = "imprecations"
  s.version     = Imprecations::VERSION
  s.authors     = ["Gabe Berke-Williams"]
  s.email       = ["gabe@thoughtbot.com"]
  s.homepage    = "https://github.com/gabebw/imprecations/"
  s.summary     = %q{Deprecate ALL THE THINGS!}
  s.description = [%q{Imprecations recursively deprecates every instance method},
                   %q{on a class/module as well as all classes defined inside that class/module.}].join(' ')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec', '~> 2.6.0')
end
