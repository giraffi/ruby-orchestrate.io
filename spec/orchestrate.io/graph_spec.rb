# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Graph do
  let(:client) { OrchestrateIo::Client.new(apikey: 'abc') }

  describe "PUT /:version/:collection/:key/realtions/:relation/:to_collection/:to_key" do
    it "creates a relationship between two objects" do
      request = client.graph :put do
        collection    "films"
        key           "the_godfather"
        relation      "sequel"
        to_collection "films"
        to_key        "the_godfather_part_2"
      end
      response = request.perform
      expect(response.code).to eql 201
    end
  end

  describe "GET /:version/:collection/:key" do
    it "returns relation’s collection, key, ref and values" do
      request = client.graph :get do
        collection    "films"
        key           "the_godfather"
        relation      "sequel"
      end

      response = request.perform
      expect(response.code).to eql 200
      expect(load_json(response.body)["results"].first["value"]["Title"]).to eql "The Godfather: Part II"
    end
  end
end
