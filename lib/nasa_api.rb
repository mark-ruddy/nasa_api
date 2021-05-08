require 'date'
require 'httparty'

module NasaApi
  BASE_URL = 'https://api.nasa.gov/'

  class Error < StandardError
    attr_reader :http_code, :http_msg, :message

    def initialize(response)
      @http_code = response.code
      @http_msg = response.message
      @message = response['error']['message'] if response['error']
    end
  end

  class NasaInit
    attr_accessor :api_key, :high_definition, :date, :options
   
    def initialize(options = {})
      @api_key = options[:api_key] || 'DEMO_KEY'

      # When testing with RSpec, uncomment the below line with your actual API key as default
      # Specs will use the default API key, e.g. the string to the right of ||
      # by default this is 'DEMO_KEY', and will cause specs to fail as DEMO_KEY is rate-limited quickly
      #
      # @api_key = options[:api_key] || 'ACTUAL_API_KEY'

      options[:api_key] = @api_key
      @options = options
    end

    def parse_date(date)
      # Allow Ruby Date/Time objects to be used
      # by changing them to the Nasa API's expected YYYY-MM-DD format
      case date
      when Time
        date.strftime("%Y-%m-%d")
      when Date
        date.to_s
      when String
        date
      end
    end

    def params_dates(params = {})
      # If date provided, parse it
      # If start/end date provided, parse them
      # If {:random = true} in params, use a random date 
      # otherwise use no date, most Nasa API's will then default to Today's date
      if params[:date]
        params[:date] = parse_date(params[:date])
        return params
      end

      if params[:start_date]
        params[:start_date] = parse_date(params[:start_date])
        if params[:end_date]
          params[:end_date] = parse_date(params[:end_date])
        end
        return params
      end 

      if params[:random]
        params[:date] = rand(Date.parse('2000-01-01')..Date.today)
        params.delete(:random)
      end
      params
    end
  end
end

require_relative "nasa_api/version"
require_relative "nasa_api/response_handler"

require_relative "nasa_api/planetary"
require_relative "nasa_api/neo"



