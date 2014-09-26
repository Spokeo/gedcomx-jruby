# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gedcomx/jruby/version'
require 'gedcomx/gedcomx'
require 'gedcomx/iterator'
require 'gedcomx/record'
require 'gedcomx/person'
require 'gedcomx/relationship'
require 'gedcomx/writer'
Dir.glob('lib/gedcomx_java_jars/*.jar').each { |jar| require jar }

Gem::Specification.new do |spec|
  spec.name          = "gedcomx-jruby"
  spec.version       = Gedcomx::Jruby::VERSION
  spec.authors       = ["Daniel Alkalai"]
  spec.email         = ["djalkalai@gmail.com"]
  spec.summary       = %q{Gedcomx ruby parser }
  spec.description   = %q{Provides ruby calls to import, process, and export Gedcomx files}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
