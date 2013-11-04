class DumbAi < AiPlayer

  attr_reader :board, :mark_value, :opposing_mark_value
  attr_accessor :turn, :coordinates

  def initialize(board,mark_value=-1)
    @board=board
    @mark_value=mark_value
    @opposing_mark_value = -@mark_value
    @coordinates=[]
    @turn=0
  end

  def play_turn
    play_random_move
  end

end