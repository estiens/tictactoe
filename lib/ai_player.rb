require_relative 'board'
require_relative 'player'

class AiPlayer < Player

attr_reader :board, :mark_value, :coordinates

  def initialize(board,mark_value=-1)
    @board=board
    @mark_value=mark_value
    @coordinates=[]
  end

  def random_value
    @coordinates << rand(@board.row_size)
    @coordinates << rand(@board.row_size)
    return @coordinates
  end

  def play_turn
    if !board.include?(-1) || !board.include?(1)
      @coordinates=take_random_corner
    else
      @coordinates=take_middle
      if check_inputs(@coordinates)
         mark space(@coordinates)
      else
        @coordinates=take_random_corner
      end
    end
  end



  def take_random_corner
    corners=[[0,0],[0,@board.row_size-1],[@board.row_size-1, 0], [@board.row_size-1,@board.row_size-1]]
    corners[rand(4)]
  end

  def take_middle
    [(@board_row.size/2), (@board.row_size/2)]
  end

  def take_random
    coordinates=random_value
  end

  def mark_space
    @board.mark_square(coordinates[0][1],mark_value)
  end

end

# class Runner
#   attr_accessor :board 

#   def initialize
#     @board=Board.new
#   end

#   def run
#     player=AiPlayer.new(board)
    
#     until @board.winner? || @board.tie?
#     print "\n"
#     board.to_s
#     player.mark_space(player.random_value)
#     sleep 1
#     end
#     print "\n"
#     board.to_s
#     puts "Player 2 won!"
  
#   end

# end

# Runner.new.run