require_relative 'spec_helper'

module NasaApi
  RSpec.describe Mars do
    let(:client) { Mars.new }

    it "has an insight url" do
      expect(Mars::INSIGHT_URL).not_to be nil
    end

    it "has a photos url" do
      expect(Mars::PHOTOS_URL).not_to be nil
    end

    describe "insight method" do
      before(:all) do
        @valid_default = { }
      end

      it "returns a ResponseHandler::MarsInsight object when valid" do
        valid_default = client.insight(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::MarsInsight)
      end
    end

    describe "photos method" do
      before(:all) do
        @valid_default = { rover: 'curiosity', sol: 5 }
      end

      it "returns a ResponseHandler::MarsPhotos object when valid" do
        valid_default = client.photos(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::MarsPhotos)
      end
    end
  end
end

