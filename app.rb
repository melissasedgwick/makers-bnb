require 'sinatra/base'
require './database_connection_setup'
require_relative './lib/property'
require './lib/user'

class MakersBnB < Sinatra::Base
  enable :sessions

  get '/' do

    @properties = Property.all
    @name = session[:current_user]
    erb :index
  end

  get '/property/:id' do
    @property = Property.find(id: params[:id])
    erb :property
  end

  get '/register' do
    erb :register
  end

  post '/registration' do
    user = User.register(name: params['name'], username: params['username'], email: params['email'], password: params['password'])
    session[:current_user] = user.name
    redirect('/')
  end


  run! if app_file == $0
end
