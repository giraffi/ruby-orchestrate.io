# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Events do
  let(:client) { OrchestrateIo.new(api_key: 'abc') }
  let(:request_data){{
    "User" => "hank_sartin",
    "Text" => "It's hard to find a moment in the film that isn't great. The Godfather lives up to the term masterpiece."
  }}

  describe "PUT /:version/:collection/:key/events/:type" do
    it "stores event at key" do
      request = client.events :put do
        collection  "films"
        key         "the_godfather"
        type        "comments"
        data         request_data
      end
      response = request.perform

      expect(response.code).to eql 201
    end
  end

  describe "GET /:version/:collection/:key/events/:type" do
    it "returns events by key" do
      client = OrchestrateIo.new(api_key: 'abc')
      request = client.events :get do
        collection  "films"
        key         "the_godfather"
        type        "comments"
      end
      response = request.perform

      expect(response.code).to eql 200
      expect(load_json(response.body)["results"].first["value"]["User"]).to eql "hank_sartin"
    end
  end
end
