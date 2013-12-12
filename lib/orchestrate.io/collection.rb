# encoding: utf-8

module OrchestrateIo
  class Collection

    attr_reader :request

    # == Usage
    #
    # io = OrchestrateIo.new(api_key: "abc")
    # request = io.collection :delete do
    #   collection  'films'
    #   key         'the_godfather'
    # end
    #
    # request.perform
    # #=> HTTParty::Response
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
      options[:query] = { force: :force }
      options
    end
  end
end
