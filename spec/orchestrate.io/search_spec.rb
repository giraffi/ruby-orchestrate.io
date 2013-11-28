require 'spec_helper'

describe OrchestrateIo::Search do
  let(:client){ OrchestrateIo::Client.new(apikey: 'abc') }

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

    it "raises ArgumentError if the query string is missing" do
      request = client.search(:get){ collection  "films" }
      expect{ request.perform }.to raise_error(ArgumentError)
    end
  end
end
