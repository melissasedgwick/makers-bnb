require 'sinatra/base'
require_relative './database_connection_setup'
require_relative './lib/property'


class MakersBnB < Sinatra::Base
  enable :sessions

  get '/' do
    @properties = Property.all
    erb :index
  end

  get '/property/:id' do
    @property = Property.find(id: params[:id])
    erb :property
  end



  run! if app_file == $0
end
