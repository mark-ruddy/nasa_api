require_relative 'spec_helper'

module NasaApi
  RSpec.describe Tech do
    let(:client) { Tech.new }

    it "has a transfer url" do
      expect(Tech::TRANSFER_URL).not_to be nil
    end

    it "has a tech_port url" do
      expect(Tech::PORT_URL).not_to be nil
    end

    describe "transfer method" do
      before(:all) do
        @valid_default = { word: 'engine' }
      end

      it "returns a ResponseHandler::TechTransfer object when valid" do
        valid_default = client.transfer(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::TechTransfer)
      end
    end

    describe "port method" do
      before(:all) do
        @valid_default = { id: 17792 }
      end

      it "returns a ResponseHandler::TechPort object when valid" do
        valid_default = client.port(@valid_default)
        expect(valid_default).to be_a(ResponseHandler::TechPort)
      end
    end
  end
end

