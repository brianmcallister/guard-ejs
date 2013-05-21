# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/ejs/version'

Gem::Specification.new do |s|
  s.name          = 'guard-ejs'
  s.version       = Guard::EJSVersion::VERSION
  s.authors       = ['Brian Wm. McAllister']
  s.email         = ['brian@brianmcallister.com']
  s.description   = %q{Guard gem for EJS}
  s.summary       = %q{guard-ejs will automatically precompile your ejs templates when they change.}
  s.homepage      = ''
  
  s.add_dependency 'guard', '>= 1.8.0'
  s.add_dependency 'ejs', '>= 1.1.1'
  
  s.add_development_dependency 'bundler'
  
  s.files = Dir.glob('{lib}/**/*')
  s.require_path = 'lib'
end
