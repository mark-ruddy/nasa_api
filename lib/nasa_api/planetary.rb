module NasaApi
  class Planetary < NasaInit
    PLANETARY_URL = BASE_URL + 'planetary/'
    APOD_URL = PLANETARY_URL + 'apod'
    EARTH_URL = PLANETARY_URL + 'earth'

    def apod(params = {}) 
      params = params_dates(params)

      # @options contains global information for all api calls, like api_key
      # merge it with the specific params for APOD calls to create full request
      params.merge!(@options)

      response = HTTParty.get(APOD_URL, query: params)
      if response.code == 200
        NasaApi::ResponseHandler::Apod.new(response) 
      else
        NasaApi::Error.new(response) 
      end
    end
  end
end
