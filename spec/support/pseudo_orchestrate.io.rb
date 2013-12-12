# encoding: utf-8
require 'sinatra/base'

class PseudoOrchestrateIo < Sinatra::Base

  # == Collection

  # DELETE /:version/:collection
  delete "/:version/:collection" do
    json_response 204
  end

  # == KeyValue

  # PUT /:version/:collection/:key
  put "/:version/:collection/:key" do
    json_response 201
  end

  # GET /:version/:collection/:key
  get "/:version/:collection/:key" do
    json_response 200, "get_values_by_key.json"
  end

  # DELETE /:version/:collection/:key
  delete "/:version/:collection/:key" do
    json_response 204
  end

  # == Search

  # GET /:version/:collection
  get "/:version/:collection" do
    json_response 200, "search_collection.json"
  end

  # == Events

  # PUT /:version/:collection/:key/events/:type
  put "/:version/:collection/:key/events/:type" do
    json_response 201
  end

  # GET /:version/:collection/:key/events/:type
  get "/:version/:collection/:key/events/:type" do
    json_response 200, "get_events_by_key.json"
  end

  # == Graph

  # PUT /:version/:collection/:key/relations/:relation
  put "/:version/:collection/:key/relations/:relation/:to_collection/:to_key" do
    json_response 201
  end

  # GET /:version/:collection/:key/relations/:relation
  get "/:version/:collection/:key/relations/:relation" do
    json_response 200, "get_graph.json"
  end

private

  def json_response(response_code, filename="")
    content_type  :json
    status        response_code
    File.open(File.join(File.dirname(__FILE__), 'fixtures', filename), 'rb').read unless filename.empty?
  end
end
