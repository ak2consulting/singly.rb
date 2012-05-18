module Singly
  class Service::Foursquare < Service
    def checkins(query={})
      get('/checkins', query)
    end
    end
  end
end
