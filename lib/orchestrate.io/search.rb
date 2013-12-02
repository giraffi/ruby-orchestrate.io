# encoding: utf-8

module OrchestrateIo
  class Search

    attr_reader :request

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
    def initialize(client, method, &block)
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
      "/:version/:collection"
    end

    def options
      options = {}
      options[:query] = { query: :query }
      options
    end
  end
end
