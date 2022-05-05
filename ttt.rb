require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

require_relative 'lib/game'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  session[:game] ||= TTTGame.new
  session[:board] ||= session[:game].board
  session[:human] ||= session[:game].human
  session[:computer]||= session[:game].computer
end

# Display game screen
get '/' do
  redirect '/play'
end

get '/play' do
  erb :game
end

post '/play/:square' do
  human_square = session[:board][params[:square].to_i]

  if human_square.marked?
    session[:error] = 'Please select an unmarked square'
  else
    human_square.marker = session[:human].marker
  end

  erb :game
end

post '/reset_board' do
  session[:board].reset
  session[:success] = "Board was reset!"
  erb :game
end
