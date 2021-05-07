module NasaApi
  class Planetary < NasaInit
    PLANETARY_URL = BASE_URL + 'planetary/'
    APOD_URL = PLANETARY_URL + 'apod'

    def apod(params = {}) 
      # If no date is provided, choose a random one
      if params[:date]
        params[:date] = parse_date(params[:date])
      else
        params[:date] = rand(Date.parse('1995-06-16')..Date.today)
      end

      # @options contains global information for all api calls, like api_key
      # merge it with the specific params for APOD calls to create full request
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
