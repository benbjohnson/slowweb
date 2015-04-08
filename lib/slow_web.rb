require 'slow_web/version'
require 'slow_web/limit'
require 'slow_web/ext/net_http'

class SlowWeb
  ##############################################################################
  # Static Initialization
  ##############################################################################
  
  # A look up of limits by host.
  @limits = {}
  
  
  ##############################################################################
  # Static Methods
  ##############################################################################

  # Limits the number of requests that can occur within a specified number of
  # seconds.
  #
  # @param [String] host  the host to restrict.
  # @param [Fixnum] count  the number of requests that can occur within a time period.
  # @param [Fixnum] period  the number of seconds in the time period.
  #
  # @return [SlowWeb::Limit] the limit object.
  def self.limit(host, count, period, margin = 0)
    raise "Limit already exists for this host: #{host}" if @limits[host]
    
    limit = Limit.new(host, count, period, margin)
    @limits[host] = limit
    return limit
  end

  # Retrieves the limit object for a given host.
  #
  # @param [String] host  the host associated with the limit.
  #
  # @return [SlowWeb::Limit] the limit object.
  def self.get_limit(host)
    return @limits[host]
  end

  # A flag stating if the limit for a given host has been exceeded.
  #
  # @param [String] host  the host that is being limited.
  #
  # @return [Boolean] a flag stating if the limit has been exceeded.
  def self.limit_exceeded?(host)
    limit = @limits[host]
    return !limit.nil? && limit.exceeded?
  end


  # Removes all limits.
  def self.reset
    @limits = {}
  end
end