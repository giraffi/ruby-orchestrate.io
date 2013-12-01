require 'spec_helper'

describe OrchestrateIo::Request do
  class Client
    def version ; "v0" ; end

    def request(http_method, uri, options={})
      "#{http_method} #{uri} with #{options}"
    end
  end

  class DummyClass
    attr_reader :request

    def initialize(method, &block)
      @request = OrchestrateIo::Request.new(Client.new, method, uri_seeds, opts_seeds, &block)
    end

    def uri_seeds
      %w{ collection key }
    end

    def opts_seeds
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
      expect(dummy.request.version).to eql "v0"
      expect(dummy.request.instance_variable_get("@collection")).to eql "films"
      expect(dummy.request.instance_variable_get("@key")).to eql "the_godfather"
      expect(dummy.request.instance_variable_get("@data")).to eql "{\"Title\": \"The Godfather\"}"
    end
  end

  describe "#perform_request" do
    it "invokes the request method at Client class" do
      expect(dummy.request.perform).to eql ''
    end
  end
end
