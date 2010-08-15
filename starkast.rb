require 'rubygems'
require 'sinatra'
require 'yaml'
require 'partials'
require 'sinatra/cache'
# my code
require 'flickr.rb'
require 'vimeo.rb'
require 'helpers.rb'

helpers Sinatra::Partials

# NB! you need to set the root of the app first
set :root, '/Users/dentarg/code/starkast.net'
set :public, '/Users/dentarg/code/starkast.net/public'
set :cache_output_dir, '/Users/dentarg/code/starkast.net/public/cache'
set :cache_enabled, true  # turn it on

def read_events
  events = YAML::load(File.open('events.yml'))
  # we want latest event on top of page
  return events.sort { |a,b| -1*(a[1][4]["date"] <=> b[1][4]["date"]) }
end

# Check if it is a valid event
def does_event_exist?(newevent, events)
  bool = false
  events.each do |event|
    if newevent == event[0]
      bool = true
    end
  end
  return bool
end

# Get requested event
def get_event(newevent, events)
  events.each do |event|
    if newevent == event[0]
      return event
    end
  end
end

$EVENTS = read_events

get '/' do
  @events = $EVENTS
  erb :index
end

get '/:event' do
  redirect "/#{params[:event]}/"
end

get '/:event/' do
  @events = $EVENTS
  if does_event_exist?(params[:event], @events)
    # render layout
    @event = get_event(params[:event], @events)
    @photos = get_photos(@event)
    erb :event
  else
    @error = "Sorry"
  end
end

get '/:event/video' do
  @events = $EVENTS
  if does_event_exist?(params[:event], @events)
    # render layout
    @event = get_event(params[:event], @events)
    @videos = get_videos(@event)
    erb :video_event
  else
    @error = "Sorry"
  end
end

get '/small/:event' do
  @events = $EVENTS
  if does_event_exist?(params[:event], @events)
    # render layout
    @event = get_event(params[:event], @events)
    @photos = get_photos(@event)
    erb :small_event
  else
    @error = "Sorry"
  end
end

not_found do
  @error = "Not found!"
  erb :index
end