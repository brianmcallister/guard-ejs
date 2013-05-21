# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/ejs/version'

Gem::Specification.new do |spec|
  spec.name          = 'guard-ejs'
  spec.version       = Guard::EJSVersion::VERSION
  spec.authors       = ['Brian Wm. McAllister']
  spec.email         = ['brian@brianmcallister.com']
  spec.description   = %q{Guard gem for EJS}
  spec.summary       = %q{guard-ejs will automatically precompile your ejs templates when they change.}
  spec.homepage      = 'will be github'
  
  s.add_dependency 'guard', '>= 1.8.0'
  
  spec.add_development_dependency 'bundler'
  
  spec.files = Dir.glob('{lib}/**/*')
  spec.require_path = 'lib'
end
