module NasaApi
  class Planetary < NasaInit
    PLANETARY_URL = BASE_URL + 'planetary/'
    APOD_URL = PLANETARY_URL + 'apod'

    def apod(params = {}) 
      params.merge!(@options)
      response = HTTParty.get(APOD_URL, query: params)
      if response['error'].nil?
        NasaApi::ResponseHandler::Apod.new(response) 
      else
        NasaApi::Error.new(response) 
      end
    end
  end
end
