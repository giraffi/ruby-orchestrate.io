# encoding: utf-8
require 'orchestrate.io/client'
require 'forwardable'

module OrchestrateIo
  class Search
    extend Forwardable

    attr_reader :client, :version, :http_method

    # == Usage
    #
    # io = OrchestrateIo.new(api_key: "abc")
    # request = io.search :get do
    #   collection  'films'
    #   query       'Genre:crime'
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
      raise ArgumentError, 'Query string is missing' if options[:query][:query].empty?
      request(http_method, uri, options)
    end
    alias :perform :perform_request

  protected

    def uri
      "/#{version}/#{@collection}"
    end

    def options
      options = {}
      options[:query] = { query: @query || {} }
      options
    end
  end
end
