# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "activerecord-i18n/version"

Gem::Specification.new do |s|
  s.name        = "activerecord-i18n"
  s.version     = ActiveRecord::I18n::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Simon Menke"]
  s.email       = ["simon.menke@gmail.com"]
  s.homepage    = "http://github.com/fd"
  s.summary     = %q{I18n for ActiveRecord.}
  s.description = %q{Storing translated/localized data should not be hard.}

  s.rubyforge_project = "activerecord-i18n"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'activerecord', '>= 2.3.8'
end
