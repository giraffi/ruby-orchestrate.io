require 'spec_helper'

describe OrchestrateIo::Request do
  class Client
    def version ; "v0" ; end
    def request(http_method, uri, options={}) ; 200 ; end
  end

  let(:request){
    OrchestrateIo::Request.new(
      args = {
        client:      Client.new,
        http_method: :get,
        uri:         "/:version/:collection/:key",
        options:     Hash[:body, :data]
      }
    ) do
      collection "films"
      key        "the_godfather"
      data       "{\"Title\": \"The Godfather\"}"
    end
  }

  describe "#uri" do
    it "returns a request uri" do
      expect(request.uri).to eql "/v0/films/the_godfather"
    end
  end

  describe "#parse_options" do
    context "simple options" do
      it "returns a request data" do
        options = Hash[:body, :data]
        result = {:body=>"{\"Title\": \"The Godfather\"}"}
        expect(request.parse_options(options)).to eql result
      end
    end

    context "nested options" do
      it "returns a request data" do
        options = Hash({ query: { query: :data }})
        result = {:query=>{:query=>"{\"Title\": \"The Godfather\"}"}}
        expect(request.parse_options(options)).to eql result
      end
    end
  end

  describe "#perform" do
    it "perform a request to the uri with the options" do
      Client.any_instance.should_receive(:request).with(:get, "/v0/films/the_godfather", {:body=>"{\"Title\": \"The Godfather\"}"}).and_return(200)
      expect(request.perform). to eql 200
    end
  end
end
