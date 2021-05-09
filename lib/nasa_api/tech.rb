module NasaApi
  class Tech < NasaInit
    TRANSFER_URL = 'https://api.nasa.gov/techtransfer/'
    PORT_URL = 'https://api.nasa.gov/techport/api/projects/'

    def transfer(params = {})
      # Query type must be appended to url like type/ instead of as parameter
      # if type is not passed, assume a patent type is requested
      params[:type] ||= 'patent'
      type = params[:type].to_s 
      params.delete(:type)

      # If item is not passed, default to '', returning all items
      params[:item] ||= ''
      item = params[:item].to_s
      params.delete(:item)

      response = HTTParty.get(TRANSFER_URL + type + '/?' + item + '&api_key=' + @options[:api_key])
      if response.code == 200
        ResponseHandler::TechTransfer.new(response)
      else
        Error.new(response)
      end
    end

    def port(params = {})
      # If id not passed, default to '', returning all projects
      params[:id] ||= ''
      id = params[:id].to_s
      params.delete(:id)

      response = HTTParty.get(PORT_URL + id + '?api_key=' + @options[:api_key])
      if response.code == 200
        ResponseHandler::TechPort.new(response)
      else
        Error.new(response)
      end
    end
  end
end

