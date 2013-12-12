# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Event do
  let(:client) { OrchestrateIo.new(api_key: 'abc') }

  describe "PUT /:version/:collection/:key/events/:type" do
    let(:request) {
      client.event :put do
        collection "films"
        key        "the_godfather"
        type       "comments"
        data       "{\"Text\" :\"It's hard to find a moment in the film that isn't great.\"}"
        timestamp   1386719809
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).
        with(:put, "/v0/films/the_godfather/events/comments", {:body=>"{\"Text\" :\"It's hard to find a moment in the film that isn't great.\"}",:query=>{:timestamp=>1386719809}}, )
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
      client.event :get do
        collection  "films"
        key         "the_godfather"
        type        "comments"
        from         1386719809  # start
        to           1386723374  # end
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).
        with(:get, "/v0/films/the_godfather/events/comments", {:query=>{:start=>1386719809, :end=>1386723374}})
      request.perform
    end

    it "returns http created with no body" do
      response = request.perform
      expect(response.code).to eql 200
      expect(response.parsed_response["results"]).to be_instance_of Array
    end
  end
end
