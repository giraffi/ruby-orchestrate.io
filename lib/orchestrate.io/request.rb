# encoding: utf-8

module OrchestrateIo
  class Request
    attr_reader :client, :version, :http_method
    attr_accessor :uri_seeds, :opts_seeds

    def initialize(client, http_method, uri_seeds, opts_seeds, &block)
      @client      = client
      @version     = client.version
      @http_method = http_method
      @uri_seeds   = uri_seeds
      @opts_seeds  = opts_seeds

      instance_eval &block if block_given?
   end

    def perform_request
      client.request(http_method, uri, options)
    end
    alias :perform :perform_request

    def uri
      "/" + version + "/" + uri_seeds.map{|seed| instance_variable_get("@#{seed}")}.join("/")
    end

    def options
      opts_seeds.each {|k,v| opts_seeds[k] = instance_variable_get("@#{v}") }
    end

    def method_missing(method, *args, &block)
      args = args.first
      self.class.class_eval do
        define_method method do |value|
          instance_variable_set("@#{method}", value)
        end
      end
      self.__send__(method, args)
    end
  end
end
