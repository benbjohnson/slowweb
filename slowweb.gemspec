# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'slow_web/version'

Gem::Specification.new do |s|
  s.name        = 'slowweb'
  s.version     = SlowWeb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Ben Johnson']
  s.email       = ['benbjohnson@yahoo.com']
  s.homepage    = 'http://github.com/benbjohnson/slowweb'
  s.summary     = 'An HTTP Request Governor'

  s.add_development_dependency('rspec', '~> 2.4.0')
  s.add_development_dependency('fakeweb', '~> 1.3.0')

  s.test_files   = Dir.glob('test/**/*')
  s.files        = Dir.glob('lib/**/*') + %w(README.md)
  s.require_path = 'lib'
end
