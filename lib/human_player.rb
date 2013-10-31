require_relative 'board.rb'

class HumanPlayer

attr_reader :board

  def initialize(board)
    @board=board
  end

  def get_input
    coordinates = [-3,-3]
      puts "\nWhat row do you want to mark?"
      row = gets.chomp.to_i
      coordinates << row
      puts "What column do you want to mark?"
      column = gets.chomp.to_i
      coordinates << column
    return coordinates
  end

  def mark_space(coordinates)
    @board.mark_square(coordinates[0], coordinates[1], 1 )
  end

  private 

  def board_length
    @board.row_size
  end

end

class Runner
  attr_accessor :board 

  def initialize
    @board=Board.new
  end

  def run
    player=HumanPlayer.new(board)
    
    until @board.winner? || @board.tie?
    board.to_s
    input=player.get_input
    player.mark_space(input)
    end
  
  end

end

Runner.new.run



