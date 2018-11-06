require 'sinatra/base'
require './database_connection_setup'
require './lib/user'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

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

  get '/login' do
    erb :login
  end

  post '/authenticating' do
    user = User.auth(params['username'], params['password'])
    if user
      session[:current_user] = user.name
      redirect('/')
    else
      flash[:notice] = 'Incorrect login details!'
      redirect('/login')
    end
  end

  run! if app_file == $0
end
