require 'sinatra/base'
require './database_connection_setup'
require './lib/user'

class MakersBnB < Sinatra::Base
  enable :sessions

  get '/' do
    @name = session[:current_user]
    p session[:current_user]
    erb :index
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
