# encoding: utf-8
require 'time'
require 'logger'

module OrchestrateIo
  module Logging
    class Pretty < Logger::Formatter
      def call(severity, time, program_name, message)
        "#{time.utc.iso8601} #{Process.pid} #{severity}: #{message}\n"
      end
    end

    class << self
      def initialize_logger(log_target = STDOUT)
        @logger = Logger.new(log_target)
        @logger.level = Logger::INFO
        @logger.formatter = Pretty.new
        @logger
      end

      def logger
        @logger || initialize_logger
      end

      def logger=(log)
        @logger = (log ? log : Logger.new('/dev/null'))
      end
    end

    def logger
      OrchestrateIo::Logging.logger
    end
  end
end
