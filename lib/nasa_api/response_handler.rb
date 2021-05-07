module NasaApi
  module ResponseHandler
    class Apod
      attr_accessor :url, :media_type, :title, :explanation, :hd_url, :date, :copyright

      def initialize(values = {})
        @url = values['url']
        @media_type = values['media_type']
        @title = values['title']
        @explanation = values['explanation']
        @hd_url = values['hdurl']
        @date = values['date']
        @copyright = values['copyright']
      end
    end
  end
end
