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
  session[:computer] ||= session[:game].computer
end

# Display game screen
get '/' do
  redirect '/play'
end

get '/play' do
  erb :game
end

post '/play/:square' do
  selected_square = session[:board][params[:square].to_i]

  human_moves(selected_square)

  if session[:board].someone_won?
    session[:success] = "Congratulations, you win!"
    session[:board].reset
  elsif session[:board].full?
    session[:error] = "The board is full, it's a draw!"
    session[:board].reset
  else
    computer_moves
  end

  if session[:board].someone_won?
    session[:error] = "The computer won. Better luck next time!"
    session[:board].reset
  end

  erb :game
end

post '/reset_board' do
  session[:board].reset
  session[:success] = "Board was reset!"
  erb :game
end
