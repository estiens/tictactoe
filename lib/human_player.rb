require_relative 'player.rb'


class HumanPlayer < Player

attr_reader :board, :mark_value, :game
attr_accessor :turn

  def initialize(board, mark_value=1)
    @board=board
    @mark_value=mark_value
    @game = game
    @turn=0
  end

  def play_turn
    if board.row_size == 3
      coordinates=get_better_input_for_3_way_board 
    else
      coordinates=get_input if board.row_size != 3
    end

    board.mark_square(coordinates[0], coordinates[1], mark_value)
  end

  # def get_input
  #     coordinates=[]
  #     puts "\nWhat row do you want to mark?"
  #     row = gets.chomp
  #     run_exit_check(row)
  #     puts "What column do you want to mark?"
  #     column = gets.chomp
  #     coordinates[0] = row.to_i
  #     coordinates[1] = column.to_i
  #     if !check_inputs(coordinates) 
  #       puts "Sorry, that's not a valid move".red
  #       get_input
  #     else
  #       return coordinates
  #     end
  # end

  def get_better_input_for_3_way_board
    coordinates=[]
    puts "\nWhat space do you want to mark"
    input = gets.chomp.to_i
    # run_exit_check(input)
    case input
      when 1
        coordinates = [0,0]
      when 2
        coordinates = [0,1]
      when 3
        coordinates = [0,2]
      when 4
        coordinates = [1,0]
      when 5 
        coordinates = [1,1]
      when 6
        coordinates = [1,2]
      when 7 
        coordinates = [2,0]
      when 8
        coordinates = [2,1]
      when 9
        coordinates = [2,2]
    end
    return coordinates
  end

  

end




