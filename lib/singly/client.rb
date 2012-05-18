module Singly
  class Client
    include Singly::ApiRequest

    attr_reader :access_token

    def initialize(access_token=nil)
      @access_token = access_token
    end

    def profiles(query={})
      get("/profiles", query)
    end

    def foursquare
      @foursquare ||= Singly::Service::Foursquare.new(self)
    end

    def instagram
      @instagram ||= Singly::Service::Instagram.new(self)
    end
  end
end
