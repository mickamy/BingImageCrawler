require 'searchbing'
require 'yaml'
require 'open-uri'
require 'open_uri_redirections'
require 'FileUtils'
require 'date'

saved_image_count = 0

def save_image(url, dir_name)
	filename = File.basename(url)
  path = dir_name + '/' + filename.to_s
	open(path, 'wb') do |file|
    begin
      open(url, allow_redirections: :all) do |data|
        file.write(data.read)
        puts "Saved #{url}"
        save_image_count += 1
      end
    rescue OpenURI::HTTPError => e
      puts "Couldn't get a image #{url} cause = #{e}"
      FileUtils.rm(file.path)
    end
  end
end

config = YAML.load_file('config.yml')
request_limit = config[:request_limit]
request_times = config[:request_times]

date = DateTime.now.strftime('%Y%m%d%H%M%S')
dir_name = "output_#{date}"

FileUtils.mkdir_p(dir_name) unless FileTest.exist?(dir_name)
bing = Bing.new(config[:api_key], request_limit, 'Image')

request_times.times do |count|
  offset = count * request_limit
  results = bing.search('clothing laundry tag', offset)

  results[0][:Image].each do |result|
    save_image(result[:MediaUrl], dir_name)
  end
end

puts '-' * 20
puts 'Finish!'
puts "Saved #{saved_image_count}} images!"