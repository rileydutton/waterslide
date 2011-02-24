# myapp.rb
require 'sinatra'
require 'playnicely'
require 'config'

enable :logging

post '/feedback' do
  
  client = PlayNicely::Client.new(PLAYNICELY_USERNAME, PLAYNICELY_PASSWORD)
  
  if(params[:type] == 'bug')
    type = 'bug'
  elsif(params[:type] == 'idea')
    type = 'idea'
  else
    type = 'bug'
  end
  
  begin
  
  item = client.create_item(PLAYNICELY_PROJECT_ID, {
    :project_id => PLAYNICELY_PROJECT_ID,
    :involved => [1426],
    :responsible => 1426,
    :subject => params[:short],
    :body => params[:long],
    :tags => ["feedback"],
    :status => "new",
    :type_name => type
  })
  
  "success"
  
  rescue PlayNicely::ClientError
    "error"
  end
  
end

get '/' do
  File.read('index.html')
end