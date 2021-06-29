require './bot'

$stdout.sync = true

run Rack::Cascade.new [API]
