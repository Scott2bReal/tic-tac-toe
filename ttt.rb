require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

require_relative 'lib/game'

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  @game = TTTGame.new
  @board = @game.board
  @human = @game.human
  @computer = @game.computer
end

# Display game screen
get '/' do
  redirect '/play'
end

get '/play' do
  erb :game
end

post '/play/:square' do
  square = params[:square]
end
