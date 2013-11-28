require 'spec_helper'

describe OrchestrateIo::KeyValue do
  describe "PUT /:version/:collection/:key" do
    let(:client) { OrchestrateIo.new(api_key: 'abc') }
    it "stores value at key" do
      request_data = '{ "Title": "The Godfather" }'
      request = client.key_value :put do
        collection  "films"
        key         "the_godfather"
        data         request_data
      end
      response = request.perform

      expect(response.code).to eql 201
    end
  end

  describe "GET /:version/:collection/:key" do
    it "returns values by key" do
      client = OrchestrateIo.new(api_key: 'abc')
      request = client.key_value :get do
        collection  "films"
        key         "the_godfather"
      end
      response = request.perform

      expect(response.code).to eql 200
      expect(load_json(response.body)["Director"]).to eql "Akira Kurosawa"
    end
  end

  describe "DELETE /:version/:collection/:key" do
    let(:client) { OrchestrateIo.new(api_key: 'abc') }
    it "deletes value at key" do
      request = client.key_value :delete do
        collection  "films"
        key         "the_godfather"
      end
      response = request.perform

      expect(response.code).to eql 204
    end
  end
end
