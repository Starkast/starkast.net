require 'rubygems'
require 'helpers.rb'
require 'httparty'

# http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/13657050
# http://vimeo.com/api/v2/album/781338/videos.json

def get_videos(event)
  album_id = get_attr("vimeo_album", event)
  video_ids = []
  videos = HTTParty.get("http://vimeo.com/api/v2/album/#{album_id}/videos.json")
  videos.each do |video|
    video_ids << video["id"]
  end
  list = []
  video_ids.each do |video_id|
    list << HTTParty.get("http://vimeo.com/api/oembed.json?url=http://vimeo.com/#{video_id}").parsed_response
  end
  return list
end

# test
#p get_videos(["13657050"])