# encoding: utf-8
require 'spec_helper'

describe OrchestrateIo do
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
    it 'creates a new client' do
      expect(OrchestrateIo.new(api_key: 'abc')).to be_an_instance_of OrchestrateIo::Client
    end
  end

  describe '.logger' do
    it 'initializes logger' do
      expect(OrchestrateIo.logger).to be_an_instance_of Logger
    end

    it 'initializes logger by custom formatter' do
      pending
      expect(OrchestrateIo.logger.formatter).to be_an_instance_of OrchestrateIo::Logging::Pretty
    end
  end

  describe '.logger=' do
    it 'initializes logger by give logger object' do
      OrchestrateIo.logger = Logger.new('application.log', 20, 'daily')
      expect(OrchestrateIo.logger).to be_an_instance_of Logger
      OrchestrateIo.logger = nil
    end
  end

  describe '.options' do
    it 'returns options reset to defaults' do
      expect(OrchestrateIo.options).to eql default_options
    end
  end
end
