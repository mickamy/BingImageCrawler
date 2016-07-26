require 'searchbing'
require 'yaml'
require 'open-uri'

def save_image(url)
	filename = File.basename(url)
	open('images/' + filename.to_s, 'wb') do |file|
    open(url) do |data|
      file.write(data.read)
    end
  end
end

config = YAML.load_file('config.yml')

bing = Bing.new(config[:api_key], config[:request_count], 'Image')
results = bing.search('clothing laundry tag')

results[0][:Image].each do |result|
  puts result[:MediaUrl]
  save_image(result[:MediaUrl])
end