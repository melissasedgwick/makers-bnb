require 'sinatra/base'
require './database_connection_setup'
require './lib/property'
require './lib/user'
require './lib/booking'
require 'sinatra/flash'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @properties = Property.all
    @name = session[:current_user]
    erb :index
  end

  post '/property/view/:id' do
    @property = Property.find(id: params[:id])
    @availability = Booking.check_availability(property_id: params[:id])
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

  get '/login' do
    erb :login
  end

  post '/authenticating' do
    user = User.auth(params['username'], params['password'])
      if user
        session[:current_user] = user
        redirect('/')
      else
        flash[:notice] = 'Incorrect login details!'
        redirect('/login')
      end
  end

  post '/logout' do
    session.clear
    flash[:notice] = "You have logged out."
    redirect('/')
  end

  get '/add-property' do
    erb :add_property
  end

  post '/add-property' do
    Property.create(name: params['name'], description: params['description'], ppn: params['ppn'])
    redirect('/')
  end

  post '/property/update/:id' do
    @property = Property.find(id: params[:id])
    erb :update
  end

  post '/update/:id' do
    Property.update(id: params[:id],name: params[:name],description: params[:description],ppn: params[:ppn])
    redirect('/')
  end

  get '/view_bookings' do
    @user = session[:current_user]

    @bookings = Booking.list_my_bookings(id: @user.id)
    erb :view_bookings
  end

  run! if app_file == $0
end
