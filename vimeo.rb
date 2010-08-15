require 'rubygems'
require 'helpers.rb'
require 'httparty'

# http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/13657050

def get_videos(event)
  video_ids = get_attr("vimeo", event)
  list = []
  video_ids.each do |video_id|
    list << HTTParty.get("http://vimeo.com/api/oembed.json?url=http://vimeo.com/#{video_id}").parsed_response
  end
  return list
end

# test
#p get_videos(["13657050"])