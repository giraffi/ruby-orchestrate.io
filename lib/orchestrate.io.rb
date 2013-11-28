# encoding: utf-8
require 'orchestrate.io/client'
require 'orchestrate.io/configuration'
require 'orchestrate.io/logging'
require 'orchestrate.io/core_ext'

module OrchestrateIo
  extend Configuration

  def self.new(attrs={})
    OrchestrateIo::Client.new(attrs)
  end

  def self.logger
    OrchestrateIo::Logging.logger
  end

  def self.logger=(log)
    OrchestrateIo::Logging.logger = log
  end
end
