# encoding: utf-8

module OrchestrateIo
  class KeyValue

    attr_reader :request

    # == Usage
    #
    # io = OrchestrateIo.new(api_key: "abc")
    # request = io.key_value :get do
    #   collection  'films'
    #   key         'kurosawa'
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
      "/:version/:collection/:key"
    end

    def options
      options = {}
      options[:body] = :data
      options
    end
  end
end
