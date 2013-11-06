require_relative 'player'

class HumanPlayer < Player

attr_reader :board, :mark_value
attr_accessor :turn

  def initialize(board, mark_value=1)
    @board=board
    @mark_value=mark_value
    @turn=0
  end

  def play_turn
    coordinates = @board.row_size == 3 ? get_better_input_for_3_way_board : get_input
    coordinates=get_input unless board.row_size == 3
    if check_inputs(coordinates)
      board.mark_square(coordinates[0], coordinates[1], mark_value)
    else
      play_turn
    end
  end

private

  def get_input
      coordinates=[]
      puts "\nWhat row do you want to mark?"
      row = gets.chomp
      run_exit_check(row)
      puts "What column do you want to mark?"
      column = gets.chomp
      coordinates = [row.to_i, column.to_i]
      unless check_inputs(coordinates)
        puts "Sorry, that's not a valid move".red
        get_input
      end
  end

  def get_better_input_for_3_way_board
    coordinates = [-1,-1]
    while coordinates == [-1,-1]
      puts "\nWhat space do you want to mark? (or 'exit')"
      input = gets.chomp
      run_exit_check(input)
      case input
        when "1"
          coordinates = [0,0]
        when "2"
          coordinates = [0,1]
        when "3"
          coordinates = [0,2]
        when "4"
          coordinates = [1,0]
        when "5"
          coordinates = [1,1]
        when "6"
          coordinates = [1,2]
        when "7"
          coordinates = [2,0]
        when "8"
          coordinates = [2,1]
        when "9"
          coordinates = [2,2]
      end
    end
    return coordinates
  end

  def run_exit_check(input)
    exit if ["exit", "quit"].include?(input.downcase)
  end

end




