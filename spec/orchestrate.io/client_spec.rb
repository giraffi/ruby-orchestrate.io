# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo::Client do
  let(:default_options) {{
    :request_headers=>{
      "User-Agent"=>"Orchestrate.io Ruby Gem #{OrchestrateIo::Version}",
      "Content-Type"=>"application/json; charset=utf-8",
      "Accept-Language"=>"ja,en"
    },
    :endpoint=>"https://api.orchestrate.io",
    :api_key=>"",
    :version=>"#{OrchestrateIo.options[:version]}",
    :verbose=>false
  }}

  describe '::new' do
    it 'initializes attributes' do
      client = OrchestrateIo.new(api_key: 'abc')
      expect(client.request_headers).to eql default_options[:request_headers]
      expect(client.endpoint).to eql default_options[:endpoint]
      expect(client.verbose).to eql default_options[:verbose]
      expect(client.version).to eql default_options[:version]
      expect(client.api_key).to eql 'abc'
    end

    it 'initializes options for client' do
      OrchestrateIo::Client.should_receive(:format).with(:json)
      OrchestrateIo::Client.should_receive(:base_uri).with(default_options[:endpoint])
      OrchestrateIo::Client.should_receive(:headers).with(default_options[:request_headers])
      OrchestrateIo.new(api_key: 'abc')
    end

    it 'sets logger level to debug' do
      OrchestrateIo.new(api_key: 'abc', verbose: true)
      expect(OrchestrateIo.logger.level).to eql Logger::DEBUG
    end

    it 'sets logger level to info' do
      OrchestrateIo.new(api_key: 'abc', verbose: false)
      expect(OrchestrateIo.logger.level).to eql Logger::INFO
    end
  end

  describe "#request" do
    pending "TODO: A lesson for Fujiwara san"
  end

  describe "#method_missing" do
    let(:client){ OrchestrateIo::Client.new(api_key: 'abc') }
    before { OrchestrateIo.stub(:request) }

    context '#key_value' do
      it 'creates a new key_value ' do
        request_data = '{ "Title": "The Godfather" }'
        expect(
          client.key_value(:get){
            collection  "films"
            key         "the_godfather"
          }
        ).to be_an_instance_of OrchestrateIo::KeyValue
      end
    end

    context '#search' do
      it 'creates a new search instance' do
        search_query = "Genre:crime"
        expect(
          client.search(:get){
            collection  "films"
            query        search_query
          }
        ).to be_an_instance_of OrchestrateIo::Search
      end
    end

    context '#event' do
      it 'creates a new event instance' do
        request_data = '{ "User": "peter_bradshaw", "Text": "A measured, deathly serious epic." }'
        expect(
          client.event(:get){
            collection  "films"
            key         "the_godfather"
            type        "comments"
          }
        ).to be_an_instance_of OrchestrateIo::Event
      end
    end

    context '#graph' do
      it 'creates a new graph instance' do
        expect(
          client.graph(:get){
            collection  "films"
            key         "the_godfather"
            relation    "sequel"
          }
        ).to be_an_instance_of OrchestrateIo::Graph
      end
    end
  end

  describe "#basic_auth" do
    let(:client){ OrchestrateIo::Client.new(api_key: 'abc') }
    it "returns an object for the basic authentication" do
      hash = client.__send__(:basic_auth)
      expect(hash[:basic_auth][:username]).to eql 'abc'
      expect(hash[:basic_auth][:password]).to be_empty
    end
  end
end
