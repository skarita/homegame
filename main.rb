require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'
require_relative 'models/user'
require_relative 'models/user_type'
require_relative 'models/game'
require_relative 'models/reservation'

enable :sessions

helpers do

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end

after do
  ActiveRecord::Base.connection.close
end

get '/session/new' do
  erb :login
end

post '/session' do
  user = User.find_by(email: params[:input_email])
  if user && user.authenticate(params[:input_password])
    # User logged in and create a new session
    session[:user_id]= user.id
    redirect to '/'
  else
    # Stay at the login form
    erb :login
  end
end

get '/session/signup' do
  erb :signup
end
# Delete session
get '/session/logout' do
  session[:user_id]=nil
  redirect to '/'
end

get '/' do
  erb :index
end

get '/about' do
  erb :about
end

get '/login' do
  erb :login
end

get '/games' do
  all_games = game.all
  all_city = []
  all_games.each do |each|
    all_city << each.city
  end
  @cities = all_city.uniq

  if params[:search_by_city] != nil
    @games = Game.where(city: params[:search_by_city]).order('post_date DESC')
    @current_city = params[:search_by_city]
  else
    # get all games
    @games = Game.order('gate_date')
  end

  erb :games_all
end

# Create new home game form
get '/games/new' do
  if logged_in?
    erb :new_game
  else
    erb :signup
  end
end

post '/games' do
  new_game = Game.new
  new_game.date = params[:input_date]
  new_game.buyin = params[:input_buyin]
  new_game.address = params[:input_address]
  new_game.city = params[:input_city]
  new_game.description = param[:input_description]
  new_game.save

  redirect to '/games'
end

# Show single game details
get "/games/:id" do
  if logged_in?
    @game = Game.find(params[:id])
    @user = @game.user
    if @user == nil
      redirect to "/games"
    end
    erb :game_show
  else
    erb :login
  end
end

get "/signup" do
  @note = "Email address"
  erb :signup
end

post "/signup/new" do
  user = User.new
  user.name = params[:input_name]
  user.email = params[:input_email]
  user.password = params[:input_password]

  # if User.all.size == 0
  #   user.user_type_id = 2 # set user as host
  # else
  #   user.user_type_id = 1 # set user as player
  # end

  exist = false
  users = User.all
  users.each do |user|
    if user.email == params[:input_email]
      exist = true
    end
  end

  if !exist
    user.save
    erb :login
  else
    @note = "Email address already exists!"
    erb :signup
  end
end
