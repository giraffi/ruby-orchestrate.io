# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Events do
  let(:client) { OrchestrateIo.new(api_key: 'abc') }

  describe "PUT /:version/:collection/:key/events/:type" do
    let(:request) {
      client.events :put do
        collection "films"
        key        "the_godfather"
        type       "comments"
        data       "{\"Text\" :\"It's hard to find a moment in the film that isn't great.\"}"
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).
        with(:put, "/v0/films/the_godfather/events/comments", {:body=>"{\"Text\" :\"It's hard to find a moment in the film that isn't great.\"}"})
      request.perform
    end

    it "returns http created with no body" do
      response = request.perform
      expect(response.code).to eql 201
      expect(response.parsed_response).to be_nil
    end
  end

  describe "GET /:version/:collection/:key/events/:type" do
    let(:request) {
      client.events :get do
        collection  "films"
        key         "the_godfather"
        type        "comments"
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).
        with(:get, "/v0/films/the_godfather/events/comments", {})
      request.perform
    end

    it "returns http created with no body" do
      response = request.perform
      expect(response.code).to eql 200
      expect(response.parsed_response["results"]).to be_instance_of Array
    end
  end
end
