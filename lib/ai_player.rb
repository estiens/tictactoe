require_relative 'board'
require_relative 'player'

class AiPlayer < Player

attr_reader :board, :mark_value

  def initialize(board,mark_value=-1)
    @board=board
    @mark_value=mark_value
  end

  def random_value
    coordinates =  []
    coordinates << rand(@board.row_size)
    coordinates << rand(@board.row_size)
    return coordinates
  end

  def play_turn
    mark_space(random_value)
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