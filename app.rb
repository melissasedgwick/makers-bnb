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
    @user = session[:current_user]
    erb :index
  end

  get '/property/view/:id' do
    @user = session[:current_user]
    @property = Property.find(id: params[:id])
    @availability = Booking.check_availability(property_id: params[:id])
    erb :property
  end

  get '/register' do
    erb :register
  end

  post '/registration' do
    if User.email_exists?(params[:email])
      flash[:notice] = 'Email already in use!'
      redirect ('/register')
    elsif User.username_exists?(params[:username])
      flash[:notice] = 'Username already in use!'
      redirect ('/register')
    else
      user = User.register(name: params['name'], username: params['username'], email: params['email'], password: params['password'])
      session[:current_user] = user
      redirect('/')
    end
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
    user = session[:current_user]
    Property.create(name: params['name'], description: params['description'], ppn: params['ppn'], letter_id: user.id)
    redirect('/')
  end

  get '/property/update/:id' do
    # p params[:id]
    @property = Property.find(id: params[:id])
    erb :update
  end

  post '/update/:id' do
    Property.update(id: params[:id],name: params[:name],description: params[:description],ppn: params[:ppn])
    redirect('/my-properties')
  end

  get '/my-properties' do
    @user = session[:current_user]
    @properties = Property.find_by_letter(letter_id: @user.id)
    @bookings = Booking.list_my_bookings(id: @user.id)
    erb :account
  end

  get '/view_bookings' do
    @user = session[:current_user]

    @bookings = Booking.list_my_bookings(id: @user.id)
    erb :view_bookings
  end

  post '/request/:id/:date' do
    @user = session[:current_user]
    @property = Property.find(id: params[:id])
    @availability = Booking.check_availability(property_id: params[:id])
    Booking.request_booking(date: params[:date],property_id: params[:id],renter_id: @user.id)
    redirect '/request-submitted'
  end

  get '/request-submitted' do
    erb :request_submitted
  end

  get '/account' do
    @user = session[:current_user]
    @properties = Property.find_by_letter(letter_id: @user.id)
    @bookings = Booking.list_my_bookings(id: @user.id)
    erb :account
  end

  post '/add-availability/:id' do
    @user = session[:current_user]
    Booking.submit_availability(date: params[:year] + params[:months] + params[:day], property_id: params[:id].to_i, letter_id: @user.id)
    redirect('/')
  end

  post '/booking/approve/:id' do
    Booking.confirm_booking(id: params[:id])
    redirect '/account'
  end

  post '/booking/deny/:id' do
    Booking.deny_booking(id: params[:id])
    redirect '/account'

  end

  run! if app_file == $0
end
