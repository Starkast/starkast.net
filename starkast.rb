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
set :root, '/Users/dentarg/code/starkast/starkast.net'
set :public, '/Users/dentarg/code/starkast/starkast.net/public'
set :cache_output_dir, '/Users/dentarg/code/starkast/starkast.net/public/cache'
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

def ends_with_html?(str)
  p "ends with html"
  p str
  str[str.length-4..str.length] == "html"
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

get '/:event/*.html' do
  if does_event_exist?(params[:event], $EVENTS)
    send_file("public/cache/#{params[:event]}/#{params[:splat]}.html")
  end
end

# Photos
get '/:event/' do
  @events = $EVENTS
  if does_event_exist?(params[:event], @events)
    # render layout
    @event = get_event(params[:event], @events)
    @event_name = params[:event]
    @num_of_sets = get_attr("sets", @event).size
    @set_index = 0
    @photos = get_photos(@event, @set_index)
    erb :event
  else
    @error = "Sorry"
  end
end

# Photos
get '/:event/photo/:set_index' do
  @events = $EVENTS
  if does_event_exist?(params[:event], @events)
    # render layout
    @event = get_event(params[:event], @events)
    @event_name = params[:event]
    @num_of_sets =  get_attr("sets", @event).size
    @set_index = params[:set_index].to_i
    if @set_index < @num_of_sets
      @photos = get_photos(@event, @set_index)
      erb :event
    else
      @error = "Sorry, that set doesn't exist"
    end
  else
    @error = "Sorry"
  end
end

# Video
get '/:event/video' do
  @events = $EVENTS
  if does_event_exist?(params[:event], @events)
    # render layout
    @event = get_event(params[:event], @events)
    @event_name = params[:event]
    @num_of_sets =  get_attr("sets", @event).size
    @videos = get_videos(@event)
    erb :video_event
  else
    @error = "Sorry"
  end
end

# Small photos
get '/small/:event' do
  @events = $EVENTS
  if does_event_exist?(params[:event], @events)
    # render layout
    @event = get_event(params[:event], @events)
    @num_of_sets =  get_attr("sets", @event).size
    @photos = get_photos(@event)
    erb :small_event
  else
    @error = "Sorry"
  end
end

not_found do
  @error = "Not found!"
end