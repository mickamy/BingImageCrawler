require 'searchbing'
require 'yaml'

config = YAML.load_file('config.yml')

puts config[:api_key]