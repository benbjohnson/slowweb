require 'slow_web/version'

class SlowWeb
  class Limit
    ############################################################################
    # Constructor
    ############################################################################

    # @param [String] host  the host to restrict.
    # @param [Fixnum] count  the number of requests that can occur within a time
    #                        period.
    # @param [Fixnum] period  the number of seconds in the time period.
    def initialize(host, count, period)
      @host   = host
      @count  = count
      @period = period

      @requests = []
    end
  

    ############################################################################
    # Public Attributes
    ############################################################################

    # The host to restrict.
    attr_accessor :host

    # The number of requests that are allowed within the time period.
    attr_accessor :count

    # The number of seconds in the time period.
    attr_accessor :period

    # The number of requests that have occurred within the current period.
    def current_request_count
      normalize_requests()
      return @requests.length
    end

    # A flag stating if the number of requests within the period has been met.
    def exceeded?
      return current_request_count >= count
    end


    ############################################################################
    # Public Methods
    ############################################################################
    
    # Adds a request that is associated with this limit
    #
    # @param [Net::HTTPRequest] request  the request associated with this limit.
    def add_request(request)
      @requests << {:obj => request, :time => Time.now}
      normalize_requests()
      nil
    end


    ############################################################################
    # Private Methods
    ############################################################################
    
    private
    
    # Removes all items in the request list that are outside of the current 
    # period.
    def normalize_requests
      @requests = @requests.find_all do |request|
        (Time.now-request[:time]) < period
      end
    end
  end
end