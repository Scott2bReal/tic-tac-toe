require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../lib/player.rb'

class PlayerTest < Minitest::Test
  def setup
    @human = Human.new
    @computer = Computer.new
  end

  def test_human_marker_is_X
    assert_equal 'X', @human.marker
  end

  def test_computer_marker_is_O
    assert_equal 'O', @computer.marker
  end

  def test_human_scores_a_point
    assert_equal 0, @human.score

    @human.scores_a_point

    assert_equal 1, @human.score
  end

  def test_computer_scores_a_point
    assert_equal 0, @computer.score

    @computer.scores_a_point

    assert_equal 1, @computer.score
  end
end
