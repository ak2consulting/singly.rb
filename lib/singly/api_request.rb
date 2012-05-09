require "httparty"

module Singly
  API_BASE = 'api.singly.com'
  API_PROTOCOL = "https://"

  module ApiRequest
    def api_base
      @api_base || API_BASE
    end

    def api_url(path)
      API_PROTOCOL + api_base + path
    end

    def get(path, options={})
      options = options.merge(:access_token => @access_token) if @access_token
      HTTParty.get(api_url(path), {:query => options})
    end
  end
end
