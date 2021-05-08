module NasaApi
  class Planetary < NasaInit
    PLANETARY_URL = BASE_URL + 'planetary/'
    APOD_URL = PLANETARY_URL + 'apod'
    EARTH_URL = PLANETARY_URL + 'earth/'

    EARTH_IMAGERY_URL = EARTH_URL + 'imagery'
    EARTH_ASSETS_URL = EARTH_URL + 'assets'

    EPIC_URL = BASE_URL + 'EPIC/api/natural'

    def apod(params = {}) 
      params = params_dates(params)

      # @options contains global information for all api calls, like api_key
      # merge it with the specific params for APOD calls to create full request
      params.merge!(@options)

      response = HTTParty.get(APOD_URL, query: params)
      if response.code == 200
        ResponseHandler::Apod.new(response)
      else
        Error.new(response)
      end
    end

    def earth_imagery(params = {})
      params = params_dates(params)
      params.merge!(@options)

      response_head = HTTParty.head(EARTH_IMAGERY_URL, query: params)
      if response_head.code == 200
        ResponseHandler::EarthImagery.new(response_head)
      else
        Error.new(response_head)
      end  
    end   

    def earth_assets(params = {})
      params = params_dates(params)
      params.merge!(@options)

      response = HTTParty.get(EARTH_ASSETS_URL, query: params)
      if response.code == 200
        ResponseHandler::EarthAssets.new(response)
      else
        Error.new(response)
      end
    end

    def epic(params = {})
      params = params_dates(params)
      params.merge!(@options)

      response = HTTParty.get(EPIC_URL, query: params)
      if response.code == 200
        ResponseHandler::Epic.new(response)
      else
        Error.new(response)
      end
    end
  end
end

