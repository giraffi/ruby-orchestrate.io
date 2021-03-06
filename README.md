# ruby-orchestrate.io

[![Gem Version](https://badge.fury.io/rb/orchestrate.io.png)](https://rubygems.org/gems/orchestrate.io)
[![Build Status](https://travis-ci.org/giraffi/ruby-orchestrate.io.png?branch=master)](https://travis-ci.org/giraffi/ruby-orchestrate.io)
[![CircleCI Status](https://circleci.com/gh/giraffi/ruby-orchestrate.io/tree/master.png?circle-token=f6bc8c6f0610f44abe0a5db8e6e95f86f1cb874c)](https://circleci.com/gh/giraffi/ruby-orchestrate.io)  

A Ruby interface to the [Orchestrate.io](https://orchestrate.io/) API

## Installation

Add this line to your application's Gemfile:

```
gem 'orchestrate.io'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install orchestrate.io
```

## Usage

Initializes the `OrchestrateIo` class with your API key to create a new object that you perform the following API calls with.

```
require 'orchestrate.io'
require 'json'

@io = OrchestrateIo.new(api_key: 'abc')
@json_data = JSON.dump({a: 1})
@search_query = "hello dolly"
```

### Collections

`NOTE`: You can create a new collection by performing a Key/Value PUT to the collection.

##### DELETE
Deletes an entire collection.

```
@io.collection :delete do
  collection "foo"
  force       true
end.perform
```

### Key/Value

##### GET
Gets the latest value assigned to a key.

```
@io.key_value :get do
  collection "foo"
  key        "bar"
end.perform
```

##### PUT
Creates or updates the value at the collection/key specified.

```
@io.key_value :put do
  collection "foo"
  key        "bar"
  data        @json_data
end.perform
```

##### DELETE
Sets the value of a key to a null object.

```
@io.key_value :delete do
  collection "foo"
  key        "bar"
end.perform
```

### Search

Returns list of items matching the lucene query.

```
@io.search :get do
  collection "foo"
  query       @query_string
end.perform
```

### Events

##### GET
Returns a list of events, optionally limited to specified time range in reverse chronological order.

```
@io.event :get do
  collection "foo"
  key        "bar"
  type       "log"
　from        1384224210
　to          1384224213
end.perform
```

##### PUT
Puts an event with an optional user defined timestamp.

```
@io.event :put do
  collection "foo"
  key        "bar"
  type       "log"
  data        @json_data
　timestamp   1384224213
end.perform
```

### Graph

##### GET
Returns relation’s collection, key, ref, and values.

```
@io.graph :get do
  collection "foo"
  key        "bar1"
  relation   "friends"
end.perform
```

##### PUT
Creates a relationship between two objects. Relations can span collections.

```
@io.graph :put do
  collection    "foo"
  key           "bar1"
  relation      "friends"
  to_collection "hoge"
  to_key        "bar2"
end.perform
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
