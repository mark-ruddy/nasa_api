require 'spec_helper.rb'

module NasaApi
  RSpec.describe NasaApi do
    it "has a version number" do
      expect(NasaApi::VERSION).not_to be nil
    end

    it "has a base url" do
      expect(NasaApi::BASE_URL).not_to be nil
    end
  end

  RSpec.describe NasaInit do
    let(:base_client) { NasaInit.new }
    let(:rand_client) { NasaInit.new(api_key: "TEST", random: true) }

    # Tests related to default API key commented out
    # This is due to testing requiring a non DEMO_KEY due to rate limits
    # Check lib/nasa_api.rb for instructions on setting a default API key for testing
    #
    # it "has a default API key" do
    #   expect(base_client.api_key).to eq('DEMO_KEY')
    # end
    #
    # it "holds the default API key in the options hash" do
    #   expect(base_client.options[:api_key]).to eq('DEMO_KEY')
    # end

    it "has a default options hash" do
      expect(base_client.options).to be_a(Hash)
    end


    it "takes hash parameters into options" do
      expect(rand_client.options[:random]).to eq(true)
      expect(rand_client.options[:api_key]).to eq("TEST")
    end

    describe "params_date method" do
      # params_date takes the current options hash as an argument,
      # if dates or random option are present the options hash is returned parsed.
      # the idea is to return the hash unchanged apart from the dates
      before(:each) do
        @base_client = NasaInit.new
        @date_obj = Date.new(2000, 1, 1) 
        @time_obj = Time.new(2005)
        @date_string = '2005-05-05'
      end

      it "returns params unchanged if no dates provided" do
        params = @base_client.params_dates(@base_client.options)
        expect(@base_client.options).to eq(params)
      end

      it "converts Ruby Date objects to YYYY-MM-DD" do
        params = @base_client.params_dates(date: @date_obj)
        expect(params[:date]).to eq('2000-01-01')
      end

      it "converts Ruby Time objects to YYYY-MM-DD" do
        params = @base_client.params_dates(date: @time_obj)
        expect(params[:date]).to eq('2005-01-01')
      end

      it "returns date strings unchanged" do
        params = @base_client.params_dates(date: @date_string)
        expect(params[:date]).to eq(@date_string)
      end

      it "returns converted start_date and end_date when passed" do
        params = @base_client.params_dates(start_date: @date_obj, end_date: @time_obj)
        expect(params[:start_date]).to eq('2000-01-01')
        expect(params[:end_date]).to eq('2005-01-01')
      end

      it "returns a random date when :random is set" do
        params = @base_client.params_dates(random: true)
        expect(params[:date]).not_to be nil

        # :random should be deleted to avoid sending an invalid API call
        expect(params[:random]).to be nil
      end
    end
  end
end
