require_relative 'spec_helper'

module NasaApi
  RSpec.describe Neo do
    let(:client) { Neo.new }
  end

  it "has a neo_lookup url" do
    expect(Neo::NEO_LOOKUP_URL).not_to be nil
  end

  it "has a neo_feed url" do
    expect(Neo::NEO_FEED_URL).not_to be nil
  end

  it "has a neo_browse url" do
    expect(Neo::NEO_BROWSE_URL).not_to be nil
  end

  describe "neo_lookup method" do
    before(:all) do
      @valid_default = { asteroid_id: 3542519 }
      @invalid_default = { lat: 2222, lon: 222 }
    end

    it "returns a ResponseHandler::NeoLookup object when valid" do
      valid_default = client.neo_lookup(@valid_default)
      expect(valid_default).to be_a(ResponseHandler::NeoLookup)
    end

    it "returns an Error object when invalid" do
      invalid_default = client.neo_lookup(@invalid_default)
      expect(invalid_default).to be_a(Error)
    end
  end

  describe "neo_feed method" do
    before(:all) do
      @valid_default = { start_date: '2000-01-01' }
      @invalid_default = { random: true, date: '2000-01-01' }
    end

    it "returns a ResponseHandler::NeoFeed object when valid" do
      valid_default = client.neo_feed(@valid_default)
      expect(valid_default).to be_a(ResponseHandler::NeoFeed)
    end

    it "returns an Error object when invalid" do
      invalid_default = client.neo_feed(@invalid_default)
      expect(invalid_default).to be_a(Error)
    end
  end

  describe "neo_browse method" do
    before(:all) do
      @valid_default = { }
      @invalid_default = { date: '2020-01-01', lat: 133 }
    end

    it "returns a ResponseHandler::NeoBrowse object when valid" do
      valid_default = client.neo_browse(@valid_default)
      expect(valid_default).to be_a(ResponseHandler::NeoBrowse)
    end

    it "returns an Error object when invalid" do
      invalid_default = client.neo_browse(@invalid_default)
      expect(invalid_default).to be_a(Error)
    end
  end
end

