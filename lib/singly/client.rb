module Singly
  class Client
    include Singly::ApiRequest

    attr_reader :access_token

    def initialize(access_token=nil)
      @access_token = access_token
    end

    def profiles
      get("/profiles")
    end
  end
end