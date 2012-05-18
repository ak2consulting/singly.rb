module Singly
  class Service::Foursquare < Service
    def checkins(query={})
      get('/checkins', query)
    end

    def recent(query={})
      get('/recent', query)
    end
  end
end
