class IoParser

  def initialize(board)
    @board=board
  end

  def get_difficulty_level
    HardAi.new(@board)
  end

end
