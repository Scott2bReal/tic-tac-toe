require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative '../lib/board.rb'

class BoardTest < Minitest::Test
  def setup
    @board = Board.new
  end

  def test_board_has_9_squares
    assert_equal 9, @board.squares.size
  end

  def test_board_starts_all_unmarked
    assert_equal (1..9).to_a, @board.unmarked_keys
  end

  def test_board_element_selector
    assert @board[1].is_a?(Square)
  end

  def test_board_element_setter
    assert_equal (1..9).to_a, @board.unmarked_keys
    @board[9] = 'X'
    assert_equal (1..8).to_a, @board.unmarked_keys
  end

  def test_center_square_unmarked
    assert @board.center_square_unmarked?

    @board[5] = 'X'

    refute @board.center_square_unmarked?
  end

  def test_full?
    refute @board.full?

    @board.squares.each do |_, square|
      square.marker = 'X'
    end

    assert @board.full?
  end

  def test_someone_won
    refute @board.someone_won?

    @board[1] = 'X'
    @board[2] = 'X'
    @board[3] = 'X'

    assert @board.someone_won?
  end

  def test_winning_marker
    assert_nil @board.winning_marker

    @board[1] = 'X'
    @board[2] = 'X'
    @board[3] = 'X'

    assert_equal 'X', @board.winning_marker
  end
end
