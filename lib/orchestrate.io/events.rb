# encoding: utf-8

module OrchestrateIo
  class Events

    attr_reader :request

    # == Usage
    #
    # io = OrchestrateIo.new(api_key: "abc")
    # request = io.events :get do
    #   collection  'films'
    #   key         'the_godfather'
    #   type        'comments'
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
      "/:version/:collection/:key/events/:type"
    end

    def options
      options = {}
      options[:body] = :data
      options[:query] = { timestamp: :timestamp, start: :from, end: :to }
      options
    end
  end
end
