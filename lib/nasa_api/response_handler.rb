module NasaApi
  module ResponseHandler
    class Apod
      attr_accessor :url, :media_type, :title, :explanation, :hd_url, :date, :copyright

      def initialize(values = {})
        if values.parsed_response.is_a?(::Hash)
          @url = values['url']
          @hd_url = values['hdurl']
          @media_type = values['media_type']
          @title = values['title']
          @explanation = values['explanation']
          @date = values['date']
          @copyright = values['copyright']
        else
          # If start_date->end_date is used an array of hashes is returned
          # Go through every hash and append its values to an array
          values.each do |values_hash|
            (@url ||= []) << values_hash['url']
            (@hd_url ||= []) << values_hash['hdurl']
            (@media_type ||= []) << values_hash['media_type']
            (@title ||= []) << values_hash['title']
            (@explanation ||= []) << values_hash['explanation']
            (@date ||= []) << values_hash['date']
            (@copyright ||= []) << values_hash['copyright']
          end
        end
      end
    end
  end
end
