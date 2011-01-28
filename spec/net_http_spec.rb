require File.join(File.dirname(File.expand_path(__FILE__)), 'spec_helper')

describe Net::HTTP do
  ##############################################################################
  # Setup
  ##############################################################################

  before do
    SlowWeb.reset
    FakeWeb.allow_net_connect = false
  end


  ##############################################################################
  # Tests
  ##############################################################################

  it 'should show limit exceeded' do
    FakeWeb.register_uri(:get, 'http://github.com', :body => 'foo')
    SlowWeb.limit('github.com', 3, 60)
    open('http://github.com')
    open('http://github.com')
    open('http://github.com')
    SlowWeb.limit_exceeded?('github.com').should be_true
  end

  it 'should not show limit exceeded after waiting' do
    FakeWeb.register_uri(:get, 'http://github.com', :body => 'foo')
    SlowWeb.limit('github.com', 3, 1)
    open('http://github.com')
    open('http://github.com')
    open('http://github.com')
    sleep(1)
    SlowWeb.limit_exceeded?('github.com').should be_false
  end

  it 'should wait for additional requests' do
    FakeWeb.register_uri(:get, 'http://github.com', :body => 'foo')
    SlowWeb.limit('github.com', 3, 1)
    t = Time.now
    open('http://github.com')
    open('http://github.com')
    open('http://github.com')
    open('http://github.com')
    (Time.now-t).should > 1
  end
end