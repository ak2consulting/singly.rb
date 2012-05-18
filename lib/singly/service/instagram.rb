module Singly
  class Service::Instagram < Service
    def feed(query={})
      get('/feed', query)
    end

    def media(query={})
      get('/media', query)
    end
  end
end
