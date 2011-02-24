# myapp.rb
require 'sinatra'
require 'playnicely'
require 'config'

enable :logging

client = PlayNicely::Client.new(PLAYNICELY_USERNAME, PLAYNICELY_PASSWORD)

post '/feedback' do
  me = client.current_user
  if(params[:type] == 'bug')
    type = 'bug'
  elsif(params[:type] == 'idea')
    type = 'idea'
  else
    type = 'bug'
  end
  
  if(!params[:short])
    params[:short] = ""
  end
  
  if(!params[:long])
    params[:long] = ""
  end
  
  begin
  
  item = client.create_item(PLAYNICELY_PROJECT_ID, {
    :project_id => PLAYNICELY_PROJECT_ID,
    :milestone_id => PLAYNICELY_MILESTONE_ID,
    :involved => [me.user_id],
    :responsible => me.user_id,
    :subject => params[:short],
    :body => params[:long],
    :tags => ["feedback"],
    :status => "new",
    :type_name => type
  })
  
  "success"
  
  rescue PlayNicely::ClientError => error
    puts error
    "error"
  end
  
end

get '/' do
  File.read('index.html')
end

get '/setup_info' do
  me = client.current_user
  my_projects = client.user_projects(me.user_id)
  puts "Logged in as #{me.username} ID: #{me.user_id}"
  puts "Your projects are:"
  my_projects.each do |project|
      puts "#{project.name} (ID: #{project.project_id})"
  end
  
  puts YAML::dump client.project_milestones(PLAYNICELY_PROJECT_ID)
  "See your console log for relevant information"
end