require File.join(File.dirname(File.expand_path(__FILE__)), 'spec_helper')

describe SlowWeb::Limit do
  ##############################################################################
  # Setup
  ##############################################################################

  before do
    @limit = SlowWeb::Limit.new('github.com', 10, 60)
  end

  after do
      @limit = nil
  end


  ##############################################################################
  # Tests
  ##############################################################################

  it 'should increase the request count when a request is added' do
    @limit.add_request({})
    @limit.current_request_count.should == 1
  end

  it 'should show the limit exceeded if request count is above threshold' do
    @limit.count = 3
    @limit.add_request({})
    @limit.add_request({})
    @limit.add_request({})
    @limit.should be_exceeded
  end

  it 'should not show the limit exceeded if request count is below threshold' do
    @limit.count = 3
    @limit.add_request({})
    @limit.add_request({})
    @limit.should_not be_exceeded
  end
end
