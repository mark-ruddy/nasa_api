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
      options[:api_key] = @api_key
      @options = options
    end

    def parse_date(date)
      case date
      when Time
        date.strftime("%Y-%m-%d")
      when Date
        date.to_s
      when String
        date
      else
        Date.today.to_s
      end
    end
  end
end

require_relative "nasa_api/version"
require_relative "nasa_api/response_handler"
require_relative "nasa_api/planetary"

