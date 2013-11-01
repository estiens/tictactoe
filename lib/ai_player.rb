require_relative 'player'

class AiPlayer < Player

attr_reader :board, :mark_value, :coordinates, :game

  def initialize(board,game,mark_value=-1)
    @board=board
    @game=game
    @mark_value=mark_value
    @coordinates=[]
  end

  def random_value
    [rand(@board.row_size), rand(@board.row_size)]
  end

  def play_turn
    @coordinates=take_middle
      if check_inputs(@coordinates)
        mark_space(@coordinates)
      else
        play_random_move
      end
  end


  def play_random_move
    @coordinates=take_random
    if check_inputs(@coordinates)
      mark_space(@coordinates)
    else
      play_random_move
    end
  end

  def check_for_self_winner(board)
    #if any move results in win, take it

  end

  def check_for_opponent_winner
    #if any move results in opponent win, block it

  end

  def take_random_corner
    corners=[[0,0],[0,@board.row_size-1],[@board.row_size-1, 0], [@board.row_size-1,@board.row_size-1]]
    corners[rand(4)]
  end

  def take_middle
    [(@board.row_size/2), (@board.row_size/2)]
  end

  def take_random
    random_value
  end

  def mark_space(coordinates)
    @board.mark_square(coordinates[0],coordinates[1],@mark_value)
  end

end
