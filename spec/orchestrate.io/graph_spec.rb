# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Graph do
  let(:client) { OrchestrateIo::Client.new(api_key: 'abc') }

  describe "PUT /:version/:collection/:key/relations/:relation/:to_collection/:to_key" do
    let(:request){
      client.graph :put do
        collection    "films"
        key           "the_godfather"
        relation      "sequel"
        to_collection "films"
        to_key        "the_godfather_part_2"
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).
        with(:put, "/v0/films/the_godfather/relations/sequel/films/the_godfather_part_2", {})
      request.perform
    end

    it "returns http created with no body"  do
      response = request.perform
      expect(response.code).to eql 201
    end
  end

  describe "GET /:version/:collection/:key/relations/:relation" do
     let(:request){
       client.graph :get do
         collection    "films"
         key           "the_godfather"
         relation      "sequel"
       end
     }

    it "performs a request with the correct options" do
      client.should_receive(:request).
        with(:get, "/v0/films/the_godfather/relations/sequel", {})
      request.perform
    end

    it "returns http ok with body" do
      response = request.perform
      expect(response.code).to eql 200
      expect(response.parsed_response["results"].first["value"]["Title"]).to eql "The Godfather: Part II"
    end
  end
end
