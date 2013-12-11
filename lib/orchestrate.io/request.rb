# encoding: utf-8

module OrchestrateIo
  class Request
    attr_reader :client, :version, :http_method

    def initialize(args, &block)
      @client      = args[:client]
      @http_method = args[:http_method]
      @uri         = args[:uri]
      @options     = args[:options]
      @version     = client.version

      instance_eval &block if block_given?
   end

    def perform
      client.request(http_method, uri, parse_options(@options))
    end

    def uri
      @uri.split(/\//).map {|str|
        str =~ /^:/ ? instance_variable_get("@" + str.gsub!(/:/,'')) : str
      }.join("/")
    end

    def parse_options(options)
      options.each {|k,v|
        if v.is_a? Hash
          parse_options(v)
        else
          if value = instance_variable_get("@#{v}")
            options[k] = value
          else
            options.delete(k)
          end
        end
      }
      options.delete_if {|k,v| v.empty? if v.is_a? Hash }
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
