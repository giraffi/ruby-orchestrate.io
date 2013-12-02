# encoding: utf-8

module OrchestrateIo
  class Graph

    attr_reader :request, :http_method

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
    def initialize(client, method, &block)
      @http_method = method
      args = {
        client: client,
        http_method: method,
        uri: uri,
        options: options
      }

      @request = OrchestrateIo::Request.new(args, &block)
    end

    def perform
      request.perform
    end

  protected

    def uri
      case http_method
      when :get
        "/:version/:collection/:key/relations/:relation"
      when :put
        "/:version/:collection/:key/relations/:relation/:to_collection/:to_key"
      end
    end

    def options
      options = {}
      options
    end
  end
end
