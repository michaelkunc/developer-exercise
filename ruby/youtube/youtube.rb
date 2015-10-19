require 'rubygems'
gem 'google-api-client', '>0.7'
require 'google/api_client'

DEVELOPER_KEY = 'AIzaSyAbQpxvB5VTvNjR1-45zKsUESM-mJY2A2c'
YOUTUBE_API_SERVICE_NAME = 'youtube'
YOUTUBE_API_VERSION = 'v3'

def get_service
  client = Google::APIClient.new(
    :key => DEVELOPER_KEY,
    :authorization => nil,
    :application_name => $PROGRAM_NAME,
    :application_version => '1.0.0'
  )
  youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

  return client, youtube
end

def main
  puts 'please enter your search'
  input = gets.chomp!

  client, youtube = get_service

  begin
    search_response = client.execute!(
      :api_method => youtube.search.list,
      :parameters => {
        :part => 'snippet',
        :q => input,
        :maxResults => 3
      }
    )
    videos = []
    search_response.data.items.each do |search_result|
      case search_result.id.kind
        when 'youtube#video'
          videos << "#{search_result.snippet.title} (https://www.youtube.com/watch?v=#{search_result.id.videoId})"
      end
    end

    puts "Videos:\n", videos, "\n"
  rescue Google::APIClient::TransmissionError => e
    puts e.result.body
  end
end

main