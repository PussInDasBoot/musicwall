# Homepage (Root path)
require 'rubygems'
require 'sinatra'

enable :sessions

get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
  @current_user = User.find(cookies[:id]) if cookies[:id]
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
    user_id: cookies[:id]
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
    email: params[:email],
    password: params[:password]
    )
  if @user.save
    redirect '/songs'
    # TODO login afterwards
  else
    erb :'login/errors'
  end
end

get '/login' do
  @user = User.new
  erb :'login/index'
end

post '/login' do
  @user = User.find_by(
    email: params[:email],
    password: params[:password])
  @user2 = User.find_by(
    email: params[:email])
  if @user
    cookies[:email] = @user.email
    cookies[:id] = @user.id
    redirect '/songs'
  else
    erb :'login/errors'
  end
end

get '/logout' do
  cookies.delete :email
  cookies.delete :id
  redirect '/'
end

get '/upvote' do
  @voted_song = Song.find params[:song]
  @voted_song.votes.create(user_id: cookies[:id])
  redirect '/songs'
end