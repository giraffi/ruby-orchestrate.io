# encoding: utf-8
require 'sinatra/base'

class PseudoOrchestrateIo < Sinatra::Base

  # == KeyValue

  # PUT /v0/:collection/:key
  put "/v0/:collection/:key" do
    json_response 201
  end

  # GET /v0/:collection/:key
  get "/v0/:collection/:key" do
    json_response 200, "get_values_by_key.json"
  end

  # DELETE /v0/:collection/:key
  delete "/v0/:collection/:key" do
    json_response 204
  end

  # == Search

  # GET /v0/:collection
  get "/v0/:collection" do
    json_response 200, "search_collection.json"
  end

  # == Event

  # PUT /:version/:collection/:key/events/:type
  put "/:version/:collection/:key/events/:type" do
    json_response 201
  end

  # GET /:version/:collection/:key/events/:type
  get "/:version/:collection/:key/events/:type" do
    json_response 200, "get_events_by_key.json"
  end

  # == Graph

  # PUT /v0/:collection/:key/relations/:relation
  put "/v0/:collection/:key/relations/:relation/:to_collection/:to_key" do
    json_response 201
  end

  # GET /v0/:collection/:key/relations/:relation
  get "/v0/:collection/:key/relations/:relation" do
    json_response 200, "get_graph.json"
  end

private

  def json_response(response_code, filename="")
    content_type  :json
    status        response_code
    File.open(File.join(File.dirname(__FILE__), 'fixtures', filename), 'rb').read unless filename.empty?
  end
end
