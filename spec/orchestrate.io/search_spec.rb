# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Search do
  let(:client){ OrchestrateIo::Client.new(api_key: 'abc') }
  let(:request){
    client.search :get do
      collection  "films"
      query       "Genre:crime"
    end
  }

  describe "GET /:version/:collection" do
    it "performs a request with the correct options" do
      client.should_receive(:request).with(:get, "/v0/films", {:query=>{:query=>"Genre:crime"}})
      request.perform
    end

    it "returns http ok with body" do
      response = request.perform
      expect(response.code).to eql 200
      expect(response.parsed_response["results"].first["value"]["Genre"]).to eql "Crime, Drama"
    end
  end
end
