module Singly
  class Service::Foursquare < Service
    def checkins
      get('/checkins')
    end
  end
end
