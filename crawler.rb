require 'searchbing'
require 'yaml'
require 'open-uri'
require 'open_uri_redirections'
require 'FileUtils'

def save_image(url, dir_name)
	filename = File.basename(url)
	open(dir_name + '/' + filename.to_s, 'wb') do |file|
    open(url, allow_redirections: :all) do |data|
      file.write(data.read)
    end
  end
end

config = YAML.load_file('config.yml')
dir_name = config[:dir_name]

FileUtils.mkdir_p(dir_name) unless FileTest.exist?(dir_name)

bing = Bing.new(config[:api_key], config[:request_count], 'Image')
results = bing.search('clothing laundry tag')

results[0][:Image].each do |result|
  puts result[:MediaUrl]
  save_image(result[:MediaUrl], dir_name)
end