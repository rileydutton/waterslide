# myapp.rb
require 'sinatra'
require 'playnicely'
require 'config'

enable :logging

post '/feedback' do
  
  client = PlayNicely::Client.new(PLAYNICELY_USERNAME, PLAYNICELY_PASSWORD)
  if(!client)
    "Error: Unable to connect to PlayNice.ly with the provided credentials. (Did you copy config.rb.example to config.rb and insert the correct values?)"
    return
  end
  
  if(params[:type] == 'bug')
    type = 'bug'
  elsif(params[:type] == 'idea')
    type = 'idea'
  else
    type = 'bug'
  end
  
  item = client.create_item(1, {
    :subject => params[:short],
    :body => params[:long],
    :tags => ["feedback"],
    :status => "new",
    :type_name => type
  })
  
  "success"
  
end

get '/' do
  File.read('index.html')
end