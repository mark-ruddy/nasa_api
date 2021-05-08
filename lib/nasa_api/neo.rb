module NasaApi
  class Neo < NasaInit
    NEO_URL = BASE_URL + 'neo/rest/v1/'
    LOOKUP_URL = NEO_URL + 'neo/'
    FEED_URL = NEO_URL + 'feed'
    BROWSE_URL = NEO_URL + 'neo/browse'

    def lookup(params = {})
      # requires customized URL as it only takes one parameter with ?asteroid_id=
      asteroid_id = params[:asteroid_id].to_s 
      response = HTTParty.get(LOOKUP_URL + asteroid_id + '?api_key=' + @options[:api_key])

      print response.request.last_uri.to_s
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
