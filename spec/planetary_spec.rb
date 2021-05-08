require 'spec_helper.rb'

module NasaApi
  RSpec.describe Planetary do
    let(:client) { Planetary.new }
    it "has a planetary url" do
      expect(Planetary::PLANETARY_URL).not_to be nil
    end

    it "has a apod url" do
      expect(Planetary::APOD_URL).not_to be nil
    end

    it "has an earth url" do
      expect(Planetary::EARTH_URL).not_to be nil
    end

    describe "apod method" do
      before(:all) do
        # Passed to apod as params hash
        @valid_rand = { random: true }
        @valid_date = { date: '2000-01-01' }
        @valid_empty = {}
        @valid_range = { start_date: Date.new(2005, 1, 1), end_date: Time.new(2005, 1, 3) }

        @invalid_broken = { unknown_key: true, date: '222222' }
        @invalid_broken_date = { date: '20000-333-22' }
      end

      it "returns a ResponseHandler::Apod object when valid_rand" do
        valid_rand = client.apod(@valid_rand)
        expect(valid_rand).to be_a(ResponseHandler::Apod)
      end
      
      it "returns a ResponseHandler::Apod object when valid_date" do
        valid_date = client.apod(@valid_date)
        expect(valid_date).to be_a(ResponseHandler::Apod)
      end
      
      it "returns a ResponseHandler::Apod object when valid_empty" do
        valid_empty = client.apod(@valid_empty)
        expect(valid_empty).to be_a(ResponseHandler::Apod)
      end
      
      it "returns a ResponseHandler::Apod object when valid_range" do
        valid_range = client.apod(@valid_range)
        expect(valid_range).to be_a(ResponseHandler::Apod)
      end

      it "returns an Error object when invalid" do
        invalid_broken = client.apod(@invalid_broken)
        expect(invalid_broken).to be_a(Error)

        invalid_broken_date = client.apod(@invalid_broken_date)
        expect(invalid_broken_date).to be_a(Error)
      end
    end

    describe "earth_imagery method" do
      before(:all) do
        @valid_default = { lon: 100.75, lat: 1.5, date: Date.new(2014, 2, 1) }
        @invalid_default = { lon: 10000009, date: Date.new(1804, 2, 2) } 
      end

      it "returns a ResponseHandler::EarthImagery object when valid" do
        valid_default = client.earth_imagery(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::EarthImagery)
      end

      it "returns an Error object when invalid" do
        invalid_default = client.earth_imagery(@invalid_default)
        expect(invalid_default).to be_a(Error)
      end 
    end

    describe "earth_assets method" do
      before(:all) do
        @valid_default = { lon: -95.33, lat: 29.78, dim: 0.025, date: '2018-01-01' }
        @invalid_default = {  lon: 22222, lat: 99999, date: Date.new(1700, 1, 1) }
      end

      it "returns a ResponseHandler::EarthAssets object when valid" do
        valid_default = client.earth_assets(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::EarthAssets)
      end

      it "returns an Error object when invalid" do
        invalid_default = client.earth_assets(@invalid_default)
        expect(invalid_default).to be_a(Error)
      end
    end
  end
end

