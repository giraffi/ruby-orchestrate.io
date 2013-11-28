#!/usr/bin/env ruby

$:.unshift File.expand_path("../../lib", __FILE__)
require 'orchestrate.io'

io = OrchestrateIo.new(api_key: '8e0236ef-42ca-451d-b2d9-d44a2994969b')

request = io.search :get do
  collection 'films'
  query      'Genre:crime'
end

response = request.perform
puts response
