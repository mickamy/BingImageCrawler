require 'searchbing'
require 'yaml'
require 'open-uri'
require 'open_uri_redirections'
require 'fileutils'
require 'date'

def save_image(url, dir_name)
  success = false
	filename = File.basename(url)
  path = dir_name + '/' + filename.to_s
	open(path, 'wb') do |file|
    begin
      open(url, allow_redirections: :all) do |data|
        file.write(data.read)
        puts "Saved #{url}"
        success = true
      end
    rescue => e
      puts "Couldn't get a image #{url} cause = #{e}"
      FileUtils.rm(file.path)
    end
  end
  success
end

puts 'Put query keyword: '
query_keyword = gets

config = YAML.load_file('config.yml')
request_limit = config[:request_limit]
request_times = config[:request_times]

date = DateTime.now.strftime('%Y%m%d%H%M%S')
dir_name = "output_#{query_keyword.gsub(' ', '_')}_#{date}"

FileUtils.mkdir_p(dir_name) unless FileTest.exist?(dir_name)
bing = Bing.new(config[:api_key], request_limit, 'Image', 'ImageFilters': 'Style:Photo')

saved_count = 0

request_times.times do |count|
  offset = count * request_limit
  results = bing.search(query_keyword, offset)

  results[0][:Image].each do |result|
    if save_image(result[:MediaUrl], dir_name)
      saved_count += 1
    end
  end
end

puts '-' * 20
puts 'Finish!'
puts "Saved #{saved_count} images!"