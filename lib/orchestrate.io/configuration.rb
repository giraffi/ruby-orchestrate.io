# encoding: utf-8
require 'orchestrate.io/version'

module OrchestrateIo
  module Configuration

    DEFAULT_REQUEST_HEADERS = {
      "User-Agent"      => "Orchestrate.io Ruby Gem #{OrchestrateIo::Version}",
      "Content-Type"    => "application/json; charset=utf-8",
      "Accept-Language" => "ja,en"
    }

    DEFAULT_ENDPOINT = "https://api.orchestrate.io"

    VALID_OPTIONS_KEYS = [
      :request_headers,
      :endpoint,
      :api_key,
      :version,
      :verbose
    ]

    attr_accessor *VALID_OPTIONS_KEYS

    def self.extended(base)
      base.reset
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each {|k| options[k] = send(k)}
      options
    end

    def reset
      self.request_headers = DEFAULT_REQUEST_HEADERS
      self.endpoint        = DEFAULT_ENDPOINT
      self.api_key         = ""
      self.version         = "v0"
      self.verbose         = false
    end
  end
end
