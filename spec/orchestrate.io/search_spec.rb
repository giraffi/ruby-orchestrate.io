# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Search do
  let(:client){ OrchestrateIo::Client.new(api_key: 'abc') }

  describe "GET /:version/:collection" do
    it "returns a list of collection" do
      request_query = 'Genre:crime'

      request = client.search :get do
        collection  "films"
        query        request_query
      end
      response = request.perform

      expect(response.code).to eql 200
      body = load_json(response.body)["results"].first["value"]
      expect(body["Genre"]).to eql "Crime, Drama"
    end
  end
end
