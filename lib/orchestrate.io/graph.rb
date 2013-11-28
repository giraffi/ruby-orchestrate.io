# encoding: utf-8
require 'orchestrate.io/client'
require 'forwardable'

module OrchestrateIo
  class Graph
    extend Forwardable

    attr_reader :client, :version, :http_method

    # == Usage
    #
    # io = OrchestrateIo.new(api_key: "abc")
    # request = io.graph :get do
    #   collection  'films'
    #   key         'the_godfather'
    #   relation    'sequel'
    # end
    #
    # request.perform
    # => HTTParty::Response
    #
    def initialize(client, http_method, &block)
      @client      = client
      @version     = client.version
      @http_method = http_method

      self.instance_eval &block if block_given?
    end

    def_delegator :@client, :request

    def method_missing(method, *args, &block)
      args = args.first
      self.class.class_eval do
        define_method method do |value|
          instance_variable_set("@#{method}", value)
        end
      end
      self.__send__(method, args)
    end

    def perform_request
      request(http_method, uri, options)
    end
    alias :perform :perform_request

  protected

    def uri
      case http_method
      when :get
        "/#{version}/#{@collection}/#{@key}/relations/#{@relation}"
      when :put
        "/#{version}/#{@collection}/#{i@key}/relations/#{@relation}/#{@to_collection}/#{@to_key}"
      end
    end

    def options
      options = {}
      options
    end
  end
end
