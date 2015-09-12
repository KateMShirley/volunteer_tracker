require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'volunteers'
)

get '/' do
  erb :login
end

get '/register' do
  erb :register
end


get '/somejunkstufftestyolo' do

  @allthemodels = OppsModel.where({ user_id: 1 })

  @total_hours = 0;

  @allthemodels.each do |model|
    @total_hours = model.hours + @total_hours
  end

  #<%= @total_hours %>



end

#################user authenication#####################

##enable server side sessions
enable :sessions

##does a user exist?
def does_user_exist?(username)
  user = UsersModel.find_by(:username => username.to_s)
  if user
    return true
  else
    return false
  end
end

##is a user logged in?
def is_not_authenticated?
  session[:user].nil?
end

##registration action
post '/register' do
  @message = ''

  if does_user_exist?(params[:username]) == true
    @message = 'Sorry, this username already exists. Please try a new one.'
    return erb :login_notice
  end

  password_salt = BCrypt::Engine.generate_salt
  password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)


  new_user = UsersModel.new
  new_user.first_name = params[:first_name]
  new_user.last_name = params[:last_name]
  new_user.username = params[:username]
  new_user.email = params[:email]
  new_user.password_hash = password_hash
  new_user.password_salt = password_salt
  new_user.save

  @message = 'You have successfully registered! Please login with your new username and password. '
  return erb :login_notice

  end

## login action
post '/' do

  @message = ''
  if does_user_exist?(params[:username]) == false
    @message = 'Sorry, but that username or password does not exist. Please try logging in again.'
    return erb :login_notice
  end

  user = UsersModel.where(:username => params[:username]).first!

  pwd = params[:password]
  if user.password_hash == BCrypt::Engine.hash_secret(pwd, user.password_salt)
    @message = 'You have been logged in successfully'
    session[:user] = user
    return erb :login_notice
  else
    @message = 'Password is incorrect. Please try again'
    return erb :login_notice
  end
end

  get '/logout' do
    session[:user] = nil
    redirect '/'
  end

  get '/dashboard' do
    if is_not_authenticated? == true
      return erb :dashboard
    else
      @message = 'Please login'
      return erb :login_notice
    end
  end





##RESTFUL api



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
  OppsModel.create(opp_object).to_json
  # body = JSON.parse(request.body.read.to_s)
  # opp = OppsModel.create(
  # title: body['title'],
  # org: body['org'],
  # hours: body['hours'],
  # description: body['description'],
  # location: body['location'],
  # category: body['category'],
  # completed: body['completed']
  # )
  # opp.to_json

end

put '/api/opportunities/:id' do
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
