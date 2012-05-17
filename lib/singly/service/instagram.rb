module Singly
  class Service::Instagram < Service
    def feed
      get('/feed')
    end

    def media
      get('/media')
    end
  end
end
