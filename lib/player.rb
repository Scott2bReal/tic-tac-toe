class Player
  attr_accessor :marker, :score
  attr_reader :name

  def initialize
    @score = 0
  end

  def scores_a_point
    self.score += 1
  end
end

class Human < Player
  def initialize
    super
    @marker = 'X'
  end
end

class Computer < Player
  def initialize
    super
    @marker = 'O'
  end

  def move(board)
  end
end
