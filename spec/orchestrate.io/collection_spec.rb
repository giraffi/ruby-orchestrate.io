# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Collection do
  let(:client) { OrchestrateIo.new(api_key: 'abc') }

  describe "DELETE /:version/:collection" do
    let(:request) {
      client.collection :delete do
        collection "films"
        force       true
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).
        with(:delete, "/v0/films", {:query=>{:force=>true}})
      request.perform
    end

    it "returns http no content" do
      response = request.perform
      expect(response.code).to eql 204
    end
  end
end
