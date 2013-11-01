require_relative 'player.rb'


class HumanPlayer < Player

attr_reader :board, :mark_value

  def initialize(board, mark_value=1)
    @board=board
    @mark_value=mark_value
  end

  def play_turn
    coordinates=get_input
    board.mark_square(coordinates[0], coordinates[1], mark_value)
  end

  def get_input
      coordinates=[]
      puts "\nWhat row do you want to mark?"
      row = gets.chomp
      run_exit_check(row)
      puts "What column do you want to mark?"
      column = gets.chomp
      coordinates[0] = row.to_i
      coordinates[1] = column.to_i
      if !check_inputs(coordinates) 
        puts "Sorry, that's not a valid move".red
        get_input
      else
        return coordinates
      end
  end

  

end




