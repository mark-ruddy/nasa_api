module NasaApi
  module ResponseHandler
    class Apod
      attr_accessor :url, :media_type, :title, :explanation, :hd_url, :date, :copyright

      def initialize(values = {})
        @url = values['url']
        @hd_url = values['hdurl']
        @media_type = values['media_type']
        @title = values['title']
        @explanation = values['explanation']
        @date = values['date']
        @copyright = values['copyright']
      end
    end
  end
end
