require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'volunteers'
)

get '/' do
  erb :index
end

get '/api/opportunities' do
  OppsModel.all.to_json
end

get '/api/opportunities/:id' do
  OppsModel.find(params[:id]).to_json
end

post '/api/opportunities' do
  request_body = JSON.parse(request.body.read.to_s)
  OppsModel.create(request_body).to_json
end

put '/api/opportunities/:id' do
  request_body = JSON.parse(request.body.read.to_s)
  @id = params[:id]
  @opps = OppsModel.find(@id)
  @opps.title = request_body[:title]
  @opps.org = request_body[:org]
  @opps.hours = request_body[:hours]
  @opps.description = request_body[:description]
  @opps.location = request_body[:location]
  @opps.category = request_body[:category]
  @opps.completed = request_body[:completed]
end

patch '/api/opportunities/:id' do
  request_body = JSON.parse(request.body.read.to_s)
  @id = params[:id]
  @opps = OppsModel.find(@id)
  @opps.title = request_body[:title]
  @opps.org = request_body[:org]
  @opps.hours = request_body[:hours]
  @opps.description = request_body[:description]
  @opps.location = request_body[:location]
  @opps.category = request_body[:category]
  @opps.completed = request_body[:completed]
end

delete '/api/opportunities/:id' do
  InstagramModel.destroy(params[:id]).to_json
end
