require 'net/http'
require 'net/https'

module Net
  class HTTP
    def request_with_slowweb(request, body = nil, &block)
      host = self.address
      limit = SlowWeb.get_limit(host)
      
      # Wait until the request limit is no longer exceeded
      while limit.exceeded?
        sleep 1
      end
      
      # Add request to limiter
      limit.add_request(request)
      
      # Continue with the original request
      request_without_slowweb(request, body, &block)
    end

    alias_method :request_without_slowweb, :request
    alias_method :request, :request_with_slowweb
  end
end
