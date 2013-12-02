require 'spec_helper'

describe OrchestrateIo::Request do
  class Client
    def version ; "v0" ; end
    def request(http_method, uri, options={})
      200
    end
  end

  class DummyClass
    attr_reader :request

    def initialize(method, &block)
      args = {
        client: Client.new,
        http_method: method,
        uri: uri,
        options: options
      }
      @request = OrchestrateIo::Request.new(args, &block)
    end

    def uri
      "/:version/:collection/:key"
    end

    def options
      options = {}
      options[:body] = :data
      options
    end
  end

  let(:dummy) {
    DummyClass.new(:get) {
      collection 'films'
      key        'the_godfather'
      data       '{"Title": "The Godfather"}'
    }
  }

  describe "::new" do
    it "initializes the attributesi to build the uri" do
      expect(dummy.request.version).to eql 'v0'
      expect(dummy.request.instance_variable_get("@collection")).to eql 'films'
      expect(dummy.request.instance_variable_get("@key")).to eql 'the_godfather'
      expect(dummy.request.instance_variable_get("@data")).to eql '{"Title": "The Godfather"}'
    end
  end

  describe "#perform_request" do
    it "invokes the request method in Client class" do
      Client.any_instance.should_receive(:request).with(:get, '/v0/films/the_godfather', {:body=>'{"Title": "The Godfather"}'}).and_return(200)
      dummy.request.perform
    end
  end
end
