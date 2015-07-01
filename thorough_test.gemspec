# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thorough_test/version'

Gem::Specification.new do |spec|
  spec.name          = 'thorough_test'
  spec.version       = Thorough::VERSION
  spec.authors       = ['Zoltan Kiss']
  spec.email         = ['zoltan.a.kiss@gmail.com']
  spec.description   = %q{Utility that will insure your latest project commits have solid testing} # rubocop:disable Metrics/LineLength
  spec.summary       = %q{Utility that will insure your latest project commits have solid testing} # rubocop:disable Metrics/LineLength
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  #spec.executables   = ['toolshed']
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'pry'
end
