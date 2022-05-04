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

# Display home screen
get '/' do
  erb :game
end
