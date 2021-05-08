module NasaApi
  module ResponseHandler
    class Apod
      attr_accessor :url, :media_type, :title, :explanation, :hd_url, :date, :copyright

      def initialize(response = {})
        if response.parsed_response.is_a?(::Hash)
          @url = response['url']
          @hd_url = response['hdurl']
          @media_type = response['media_type']
          @title = response['title']
          @explanation = response['explanation']
          @date = response['date']
          @copyright = response['copyright']
          @service_version = response['service_version']
        else
          # If start_date->end_date is used an array of hashes is returned
          # Go through every hash and append its response to an array
          response.each do |values|
            (@url ||= []) << values['url']
            (@hd_url ||= []) << values['hdurl']
            (@media_type ||= []) << values['media_type']
            (@title ||= []) << values['title']
            (@explanation ||= []) << values['explanation']
            (@date ||= []) << values['date']
            (@copyright ||= []) << values['copyright']
            (@service_version ||= []) << values['service_version']
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

    class Epic
      attr_accessor :identifier, :caption, :image, :image_url, :version, :centroid_coordinates, :dscovr_j2000_position, :lunar_j2000_position, :sun_j2000_position, :attitude_quaternions, :date, :coords

      def initialize(response = {})
        response.each do |values|
          (@identifier ||= []) << values['identifier']
          (@caption ||= []) << values['caption']
          (@image ||= []) << values['image']
          (@version ||= []) << values['version']
          (@centroid_coordinates ||= []) << values['centroid_coordinates']
          (@dscovr_j2000_position ||= []) << values['dscovr_j2000_position']
          (@lunar_j2000_position ||= []) << values['lunar_j2000_position']
          (@sun_j2000_position ||= []) << values['sun_j2000_position']
          (@attitude_quaternions ||= []) << values['attitude_quaternions']
          (@date ||= []) << values['date']
          (@coords ||= []) << values['coords']

          # Images are stored in an archive by YYYY/DD/MM url
          # Requires a little extra logic to retrieve image_url
          date_parsed = @date[-1].split(' ')[0]
          parts = date_parsed.split('-')
          (@image_url ||= []) << "https://epic.gsfc.nasa.gov/archive/natural/#{parts[0]}/#{parts[1]}/#{parts[2]}/png/#{@image}"
        end
      end
    end
  end
end
