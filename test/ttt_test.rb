ENV["RACK_ENV"] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../ttt.rb'

class TTTTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_no_path_redirects_to_game
    get '/'

    assert_equal 302, last_response.status

    get last_response["Location"]

    assert_equal 200, last_response.status
    assert_equal 'text/html;charset=utf-8', last_response["Content-Type"]
    assert_includes last_response.body, 'Tic Tac Toe'
  end

  def test_player_can_mark_selected_square
    get '/'

    refute_includes last_response.body, 'X'

    post '/play/5'

    assert_equal 200, last_response.status
    assert_includes last_response.body, 'X'
  end

  def test_player_cannot_select_occupied_square
    post '/play/5'

    assert_includes last_response.body, 'X'

    post '/play/5'

    assert_includes last_response.body, 'unmarked'
  end
end 
