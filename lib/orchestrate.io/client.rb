# encoding: utf-8
require 'httparty'
require 'orchestrate.io/helper'
require 'orchestrate.io/configuration'
require 'orchestrate.io/key_value'
require 'orchestrate.io/search'
require 'orchestrate.io/event'
require 'orchestrate.io/graph'

module OrchestrateIo
  class Client
    include HTTParty
    include Helper

    attr_accessor *Configuration::VALID_OPTIONS_KEYS

    def initialize(attrs={})
      attrs = OrchestrateIo.options.merge(attrs)

      Configuration::VALID_OPTIONS_KEYS.each do |k|
        instance_variable_set("@#{k}".to_sym, attrs[k])
      end

      initialize_client
      logger.level = verbose ? ::Logger::DEBUG : ::Logger::INFO
    end

    ##
    # Updates HTTParty default settings
    #
    def initialize_client
      self.class.format   :json
      self.class.base_uri endpoint
      self.class.headers  request_headers
    end

    ##
    # Entry point to HTTP request
    # Set the username of basic auth to the API Key attribute.
    #
    def request(http_method, uri, options={})
      response = self.class.__send__(http_method, uri, options.merge!(basic_auth))
      # Add some logger.debug here ...
      response
    end

    def method_missing(name, *args, &block)
      OrchestrateIo.const_get(name.to_s.camelize!).new(self, args.first, &block)
    end

  protected

    def basic_auth
      { basic_auth: { username: api_key, password: "" } }
    end
  end
end
