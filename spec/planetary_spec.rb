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
  end
end

