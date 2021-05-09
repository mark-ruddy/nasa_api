module NasaApi
  class Mars < NasaInit
    INSIGHT_URL = BASE_URL + 'insight_weather/'
    PHOTOS_URL = BASE_URL + 'mars-photos/api/v1/rovers/'

    def insight(params = {})
      params[:feedtype] ||= 'json'
      params[:ver] ||= '1.0'
      params.merge!(@options)

      response = HTTParty.get(INSIGHT_URL, query: params)
      if response.code == 200
        ResponseHandler::MarsInsight.new(response)
      else
        Error.new(response)
      end
    end

    def photos(params = {})
      params[:rover] ||= 'curiosity' 
      photo_rover_url = PHOTOS_URL + params[:rover].to_s + '/photos'
      params.merge!(@options)
      response = HTTParty.get(photo_rover_url, query: params)
      if response.code == 200
        ResponseHandler::MarsPhotos.new(response)
      else
        Error.new(response)
      end
    end
  end
end

