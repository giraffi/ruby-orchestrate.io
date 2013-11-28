# encoding: utf-8

module OrchestrateIo
  module Helper

    ##
    # Returns current time in millisecond
    #
    def current_time
      Time.now.instance_eval { self.to_i * 1000 + (usec/1000) }
    end

    ##
    # Alias for ::Logging.logger
    #
    def logger
      OrchestrateIo.logger
    end
  end
end
