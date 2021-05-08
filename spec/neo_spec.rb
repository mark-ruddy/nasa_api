require_relative 'spec_helper'

module NasaApi
  RSpec.describe Neo do
    let(:client) { Neo.new }

    it "has a neo_lookup url" do
      expect(Neo::LOOKUP_URL).not_to be nil
    end

    it "has a neo_feed url" do
      expect(Neo::FEED_URL).not_to be nil
    end

    it "has a neo_browse url" do
      expect(Neo::BROWSE_URL).not_to be nil
    end

    describe "lookup method" do
      before(:all) do
        @valid_default = { asteroid_id: 3542519 }
        @invalid_default = { lat: 2222, lon: 222 }
      end

      it "returns a ResponseHandler::NeoLookup object when valid" do
        valid_default = client.lookup(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::NeoLookup)
      end

      it "returns an Error object when invalid" do
        invalid_default = client.lookup(@invalid_default)
        expect(invalid_default).to be_a(Error)
      end
    end

    describe "feed method" do
      before(:all) do
        @valid_default = { start_date: '2021-01-01', end_date: '2021-01-05' }
      end

      it "returns a ResponseHandler::NeoFeed object when valid" do
        valid_default = client.feed(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::NeoFeed)
      end
    end

    describe "browse method" do
      before(:all) do
        @valid_default = { }
      end

      it "returns a ResponseHandler::NeoBrowse object when valid" do
        valid_default = client.browse(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::NeoBrowse)
      end
    end
  end
end
