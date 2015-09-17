class UsersController < ApplicationController


  ##does a user exist?
  def does_user_exist?(username)
    user = UsersModel.find_by(:username => username.to_s)
    if user
      return true
    else
      return false
    end
  end

  get '/login' do
    erb :login
  end

  get '/register' do
    erb :register
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
  post '/login' do

    @message = ''
    if does_user_exist?(params[:username]) == false
      @message = 'Sorry, but that username or password does not exist. Please try logging in again.'
      return erb :login_notice
    end

    @user = UsersModel.where(:username => params[:username]).first!

    pwd = params[:password]
    if @user.password_hash == BCrypt::Engine.hash_secret(pwd, @user.password_salt)
      @message = 'Welcome Back! '
      session[:user] = @user
      redirect '/users/dashboard'
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
        redirect '/users/login'
      elsif
        @current_user = session[:user]
      end

      @allthemodels = OppsModel.where({ user_id: @current_user.id })
      @total_hours = 0;
      @allthemodels.each do |model|
      @total_hours = model.hours + @total_hours
      end

      @alltheorgs = OppsModel.where({ user_id: @current_user.id }).distinct.count(:org)
      @allthecategs = OppsModel.where({ user_id: @current_user.id }).distinct.count(:category)

      puts @alltheorgs
      puts @allthecategs

        erb :dashboard

    end

end
