require 'rubygems'
require 'flickraw'
require 'helpers.rb'
require 'flickr_apikey.rb'

def get_photos(event)
  set_id = get_attr("sets", event)[0] # only support one set for now
  photos = flickr.photosets.getPhotos(:photoset_id => set_id).photo
  list = []
  photos.each do |photo|
    info = flickr.photos.getInfo(:photo_id => photo.id)
    list << {
#     :img_url => FlickRaw.url_z(info),
      :medium_img_url => FlickRaw.url(info),
      :large_img_url => FlickRaw.url_b(info),
      :photo_page_url => info.urls.url[0]["_content"],
      :title => info.title,
      :description => info.description
    }
#    sizes = flickr.photos.getSizes(:photo_id => photo.id)
#    sizes
  end
  list
end

# Testing
#event = ["arvika2010", [{"name"=>"Arvika"}, {"full_name"=>"Arvikafestivalen"}, {"year"=>2010}, {"sets"=>[72157606579540000]}, {"date"=>20100728}]]
#p get_photos(event)

