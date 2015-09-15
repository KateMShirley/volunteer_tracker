class ApplicationController < Sinatra::Base
require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'volunteers'
)

##enable server side sessions
enable :sessions

##is a user logged in?
def is_not_authenticated?
  session[:user].nil?
end

set :views, File.expand_path('../../Views',__FILE__)
# set :public_folder, File.expand_path('../../Public',__FILE__)
set :public_dir, File.expand_path('../../Public', __FILE__)

##########################Base Routing#################################

get '/' do
  erb :index

end




##########################Starter Code from James for DB logic#######################

# get '/somejunkstufftestyolo' do
#
#   @allthemodels = OppsModel.where({ user_id: 1 })
#
#   @total_hours = 0;
#
#   @allthemodels.each do |model|
#     @total_hours = model.hours + @total_hours
#   end
#
#   #<%= @total_hours %>
#
# end
























############################RESTFUL api#######################################



def opp_id
  opp_params = { :id => params[:id]}
end

def opp_object
  opp_params = {
    :user_id => params[:user_id],
    :title => params[:title],
    :org => params[:org],
    :hours => params[:hours],
    :description => params[:description],
    :location => params[:location],
    :category => params[:category],
    :completed => params[:completed]
  }
end

def opp_object_update
  opp_params = {
    :user_id => params[:user_id],
    :id => params[:id],
    :title => params[:title],
    :org => params[:org],
    :hours => params[:hours],
    :description => params[:description],
    :location => params[:location],
    :category => params[:category],
    :completed => params[:completed]
  }
end

get '/api/opportunities' do
  OppsModel.all.to_json
end

get '/api/opportunities/:id' do
  OppsModel.find(params[:id]).to_json
end

post '/api/opportunities' do
  @request_body = JSON.parse(request.body.read.to_s) #{"title"=>"asdasd", "org"=>"asdasdasdsa", "hours"=>32, "category"=>"Women"}
  OppsModel.create(@request_body).to_json

end

put '/api/opportunities/:id' do
  @opp = OppsModel.find(opp_object_update[:id])
  #@request_body = JSON.parse(request.body.read.to_s) #{"title"=>"asdasd", "org"=>"asdasdasdsa", "hours"=>32, "category"=>"Women"}
  #OppsModel.update(@request_body)
  @opp.user_id = opp_object_update[:user_id]
  @opp.title = opp_object_update[:title]
  @opp.org = opp_object_update[:org]
  @opp.hours = opp_object_update[:hours]
  @opp.description = opp_object_update[:description]
  @opp.location = opp_object_update[:location]
  @opp.category = opp_object_update[:category]
  @opp.completed = opp_object_update[:completed]
  @opp.save
  @opp.to_json
end

patch '/api/opportunities/:id' do
  @opp = OppsModel.find(opp_object_update[:id])
  @opp.user_id = opp_object_update[:user_id]
  @opp.title = opp_object_update[:title]
  @opp.org = opp_object_update[:org]
  @opp.hours = opp_object_update[:hours]
  @opp.description = opp_object_update[:description]
  @opp.location = opp_object_update[:location]
  @opp.category = opp_object_update[:category]
  @opp.completed = opp_object_update[:completed]
  @opp.save
  @opp.to_json
end

delete '/api/opportunities/:id' do
  OppsModel.destroy(params[:id]).to_json
end
end
