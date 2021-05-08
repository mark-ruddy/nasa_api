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
          @service_version = values['service_version']
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
            (@service_version ||= []) << values_hash['service_version']
          end
        end
      end
    end

    class EarthImagery
      attr_accessor :url

      def initialize(response_head)
        @url = response_head.uri.to_s
      end
    end

    class EarthAssets
      attr_accessor :url, :date, :id, :resource

      def initialize(response = {})
        @url = response['head']
        @date = response['date']
        @id = response['id']
        @resource = response['resource']
        @service_version = response['service_version']
      end
    end
    
    class NeoLookup
      attr_accessor :links, :id, :neo_reference_id, :name, :designation, :nasa_jpl_url, :absolute_magnitude_h, :estimated_diameter, :is_potentially_hazardous_asteroid, :close_approach_data, :orbital_data, :is_sentry_object

      def initialize(response = {})
        @links = response['links']
        @id = response['id']
        @neo_reference_id = response['neo_reference_id']
        @name = response['name']
        @designation = response['designation']
        @nasa_jpl_url = response['nasa_jpl_url']
        @absolute_magnitude_h = response['absolute_magnitude_h']
        @estimated_diameter = response['estimated_diameter']
        @is_potentially_hazardous_asteroid = response['is_potentially_hazardous_asteroid']
        @close_approach_data = response['close_approach_data']
        @orbital_data = response['orbital_data']
        @is_sentry_object = response['is_sentry_object']
      end
    end

    class NeoFeed
      attr_accessor :links, :element_count, :near_earth_objects

      def initialize(response = {})
        @links = response['links']
        @element_count = response['element_count']
        @near_earth_objects = response['near_earth_objects']
      end
    end

    class NeoBrowse
      attr_accessor :links, :page, :near_earth_objects

      def initialize(response = {})
        @links = response['links']
        @page = response['page']
        @near_earth_objects = response['near_earth_objects']
      end
    end
  end
end
