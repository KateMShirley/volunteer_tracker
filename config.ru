require 'sinatra/base'

require './controllers/ApplicationController'
require './controllers/UsersController'
require './models/OppsModel'
require './models/UsersModel'

run Sinatra::Application

map('/') {run ApplicationController}
map('/users') {run UsersController}
