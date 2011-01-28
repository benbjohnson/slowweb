require File.join(File.dirname(File.expand_path(__FILE__)), 'spec_helper')

describe SlowWeb do
  ##############################################################################
  # Setup
  ##############################################################################

  before do
    SlowWeb.reset
  end


  ##############################################################################
  # Tests
  ##############################################################################

  it 'should add limit' do
    SlowWeb.limit('github.com', 10, 60)
    limit = SlowWeb.get_limit('github.com');
    limit.host.should == 'github.com'
    limit.count.should == 10
    limit.period.should == 60
  end

  it 'should error when limiting the same host twice' do
    SlowWeb.limit('github.com', 10, 60)
    lambda {SlowWeb.limit('github.com', 10, 60)}.should raise_error('Limit already exists for this host: github.com')
  end

  it 'should show limit exceeded' do
    SlowWeb.limit('github.com', 3, 60)
    limit = SlowWeb.get_limit('github.com');
    limit.add_request({})
    limit.add_request({})
    limit.add_request({})
    SlowWeb.limit_exceeded?('github.com').should be_true
  end
end