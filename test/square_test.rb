require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../lib/square.rb'

class SquareTest < Minitest::Test
  def setup
    @square = Square.new
  end

  def test_initial_marker_is_whitespace
    assert_equal ' ', @square.marker
  end

  def test_square_can_be_marked
    assert_equal ' ', @square.marker
    @square.marker = 'X'
    assert_equal 'X', @square.marker
  end

  def test_marked_while_unmarked
    refute @square.marked?
  end

  def test_unmarked_while_unmarked
    assert @square.unmarked?
  end
  
  def test_marked_after_marking
    refute @square.marked?
    @square.marker = 'X'
    assert @square.marked?
  end

  def test_unmarked_after_marking
    assert @square.unmarked?
    @square.marker = 'X'
    refute @square.unmarked?
  end

  def test_squares_can_be_compared
    second_unmarked_square = Square.new

    assert @square == second_unmarked_square
  end

  def test_to_s
    assert_equal ' ', @square.to_s
  end
end
