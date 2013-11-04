class MediumAi < AiPlayer

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
    if @turn == 0 
      play_first_turn
    elsif check_for_self_winner
      mark_space(check_for_self_winner)
    elsif check_for_opponent_winner
      mark_space(check_for_opponent_winner)
    else
    play_random_move
    end
  end

end