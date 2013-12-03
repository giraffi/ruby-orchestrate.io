# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::KeyValue do
  let(:client){ OrchestrateIo.new(api_key: 'abc') }

  describe "PUT /:version/:collection/:key" do
    let(:request){
      client.key_value :put do
        collection "films"
        key        "the_godfather"
        data       "{\"Title\": \"The Godfather\"}"
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).
        with(:put, "/v0/films/the_godfather", {:body=>"{\"Title\": \"The Godfather\"}"})
      request.perform
    end

    it "returns http created with no body" do
      response = request.perform
      expect(response.code).to eql 201
      expect(response.parsed_response).to be_nil
    end
  end

  describe "GET /:version/:collection/:key" do
    let(:request){
      client.key_value :get do
        collection "films"
        key        "the_godfather"
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).with(:get, "/v0/films/the_godfather", {})
      request.perform
    end

    it "returns http ok with body" do
      response = request.perform
      expect(response.code).to eql 200
      expect(response.parsed_response["Director"]).to eql "Akira Kurosawa"
    end
  end

  describe "DELETE /:version/:collection/:key" do
    let(:request){
      client.key_value :delete do
        collection "films"
        key        "the_godfather"
      end
    }

    it "performs a request with the correct options" do
      client.should_receive(:request).with(:delete, "/v0/films/the_godfather", {})
      request.perform
    end

    it "returns http no content" do
      response = request.perform
      expect(response.code).to eql 204
    end
  end
end
