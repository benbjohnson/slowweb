dir = File.dirname(File.expand_path(__FILE__))
$:.unshift(File.join(dir, '..', 'lib'))
$:.unshift(dir)

require 'rubygems'
require 'bundler/setup'
require 'open-uri'
require 'rspec'
require 'fakeweb'
require 'slowweb'

# Configure RSpec
Rspec.configure do |c|
  c.mock_with :rspec
end
