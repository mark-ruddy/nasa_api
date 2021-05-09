module NasaApi
  class Neo < NasaInit
    NEO_URL = BASE_URL + 'neo/rest/v1/'
    LOOKUP_URL = NEO_URL + 'neo/'
    FEED_URL = NEO_URL + 'feed'
    BROWSE_URL = NEO_URL + 'neo/browse'

    def lookup(params = {})
      # requires customised URL as it only takes one parameter which doesn't respond to ?asteroid_id=

      params[:asteroid_id] ||= 0
      asteroid_id = params[:asteroid_id].to_s 
      params.delete(:asteroid_id)
      params.merge!(@options)
      response = HTTParty.get(LOOKUP_URL + asteroid_id, query: params)
      if response.code == 200
        ResponseHandler::NeoLookup.new(response)
      else
        Error.new(response)
      end
    end

    def feed(params = {})
      params = params_dates(params)
      params.merge!(@options)

      response = HTTParty.get(FEED_URL, query: params)
      if response.code == 200
        ResponseHandler::NeoFeed.new(response)
      else
        Error.new(response)
      end
    end

    def browse(params = {})
      params.merge!(@options)

      response = HTTParty.get(BROWSE_URL, query: params)
      if response.code == 200
        ResponseHandler::NeoBrowse.new(response)
      else
        Error.new(response)
      end
    end
  end
end
