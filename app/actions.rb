# Homepage (Root path)
require 'rubygems'
require 'sinatra'

enable :sessions

helpers do
  def current_user
    @current_user ||= User.find_by(id: session[:id])
  end

  def logged_in?
    current_user != nil
  end
end

get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

post '/add_song' do
  @song = Song.new(
    title: params[:title],
    author: params[:author],
    url: params[:url],
    user_id: current_user.id
    )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

get '/songs/:id' do
  @song = Song.find params[:id]
  erb :'songs/show'
end

post '/signup' do
  @user = User.new(
    email: params[:email])
  @user.password = params[:password]
  if @user.save
    redirect '/songs'
    # TODO login afterwards
  else
    erb :'login/errors'
  end
end

get '/login' do
  @user_placeholder = User.new
  erb :'login/index'
end

post '/login' do
  @user = User.find_by(
    email: params[:email])
    # password: params[:password])
  # @user2 = User.find_by(
  #   email: params[:email])
  if @user && @user.password == params[:password]
    session[:email] = @user.email
    session[:id] = @user.id
    redirect '/songs'
  else
    erb :'login/errors'
  end
end

get '/logout' do
  session.delete(:email)
  session.delete(:id)
  redirect '/'
end

#Should this be post?
get '/upvote' do
  @voted_song = Song.find params[:song]
  @voted_song.votes.create(user_id: session[:id])
  redirect '/songs'
end

post '/add_review' do
  @reviewed_song = Song.find params[:song]
  @reviewed_song.reviews.create(content: params[:content], user_id: current_user.id)
  redirect '/songs'
end

get '/delete_review' do
  @delete_review = Review.find params[:dr]
  @delete_review.destroy
  redirect '/songs'
end