# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "one_offs/version"

Gem::Specification.new do |s|
  s.name        = 'one_offs'
  s.version     = OneOffs::VERSION
  s.authors     = ['Jatin Naik']
  s.email       = ['jsnaik@gmail.com']
  s.homepage    = 'http://github.com/tinygrasshopper/one_offs'
  s.summary     = 'Track and manage your one off scripts'
  s.description = 'Track and manage your one off scripts with rake'

  s.rubyforge_project = 'one_offs'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency(%q<activerecord>, ['~> 1.15', '>= 1.15.6'])
end
