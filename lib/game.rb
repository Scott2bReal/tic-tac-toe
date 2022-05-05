require_relative 'board'
require_relative 'player'
require_relative 'square'

class TTTGame
  DANGER_SQUARES = {
    1 => [[2, 3], [4, 7], [5, 9]],
    2 => [[1, 3], [5, 8]],
    3 => [[1, 2], [6, 9], [5, 7]],
    4 => [[1, 7], [5, 6]],
    5 => [[1, 9], [3, 7], [4, 6], [2, 8]],
    6 => [[4, 5], [3, 9]],
    7 => [[8, 9], [1, 4], [3, 5]],
    8 => [[7, 9], [2, 5]],
    9 => [[7, 8], [3, 6], [1, 5]]
  }

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Computer.new
    @current_player = @human
  end

  attr_reader :board, :human, :computer
  attr_accessor :current_player

  def players_take_turns(selected_square)
    # loop do
    #   current_player == human ? human_moves(human_square) : computer_moves

    #   break if board.someone_won? || board.full?

    #   switch_current_player
    # end

    # current_player.scores_a_point if board.someone_won?
    human_moves(selected_square)
    
    if session[:board].someone_won?
      return session[:success] = "You win!"
    elsif session[:board].full?
      return sesion[:error] = "The board is full, it's a draw"
    end

    computer_moves

    if session[:board].someone_won?
      return session[:success] = "You win!"
    elsif session[:board].full?
      return sesion[:error] = "The board is full, it's a draw"
    end
  end

  def computer_moves
    computer_move = try_offense_then_defense

    if computer_move
      session[:board][computer_move] = session[:computer].marker
    elsif session[:board].center_square_unmarked?
      session[:board][Board::CENTER_SQUARE] = session[:computer].marker
    else
      square = session[:board].unmarked_keys.sample
      session[:board][square] = session[:computer].marker
    end
  end

  def try_offense_then_defense # returns advantageous move or nil
    [session[:computer], session[:human]].each do |player|
      at_risk = at_risk_squares(squares_marked_by(player))
      return at_risk.sample unless at_risk.empty?
    end

    nil
  end

  def at_risk_squares(player_squares)
    at_risk = []

    session[:board].unmarked_keys.each do |key|
      player_squares.combination(2) do |combo|
        at_risk << key if TTTGame::DANGER_SQUARES[key].include?(combo)
      end
    end

    at_risk
  end

  def squares_marked_by(player)
    marked_squares = []

    (1..9).each do |key|
      marked_squares << key if session[:board][key].marker == player.marker
    end

    marked_squares
  end

  def human_moves(selected_square)
    if selected_square.marked?
      session[:error] = 'Please select an unmarked square'
    else
      selected_square.marker = session[:human].marker
    end
  end

  def reset_game
    board.reset
    self.current_player = @human
    clear
  end

  def switch_current_player
    self.current_player = current_player == human ? computer : human
  end

  def human_turn?
    current_player == human
  end

  def reset_match
    board.reset
    reset_game
    [human, computer].each do |player|
      player.score = 0
    end
  end
end
