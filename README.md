# ruby-orchestrate.io

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

```
require 'orchestrate.io'
require 'json'

@io = OrchestrateIo.new(apikey: 'abc')
@json_data = JSON.dump({a: 1})
@search_query = "hello dolly"
```

#### Key/Value

```
@io.key_value :put do
  collection "foo"
  key        "bar"
　timestamp   1384224213
  data        @json_data
end

@io.key_values :get do
  collection "foo"
  key        "bar"
end
```

#### Search

```
@io.search do
  collection "foo"
  query       @query_string
end
```

#### Events

```
@io.events :put do
  collection "foo"
  key        "bar"
  type       "log"
　timestamp   1384224213
  data        @json_data
end

@io.events :get do
  collection "foo"
  key        "bar"
  type       "log"
　start       1384224210
　end         1384224213
end
```

#### Graph

```
@io.graph :put do
  collection    "foo"
  key           "bar1"
  relation      "friends"
  to_collection "hoge"
  to_key        "bar2"
end

@io.graph :get do
  collection "foo"
  key        "bar1"
  relation   "friends"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
