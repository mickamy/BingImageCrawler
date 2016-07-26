require 'searchbing'
require 'yaml'

config = YAML.load_file('config.yml')
puts config[:api_key]
puts config[:request_count]
puts config[:query]

# bing = Bing.new(config[:api_key], config[:request_count], 'Image')
# results = bing.search(config[:query])
# puts results