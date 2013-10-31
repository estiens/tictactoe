require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'ai_player.rb'

class HumanPlayer

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

  def check_inputs(coordinates)
    run_range_checks(coordinates) && check_input_for_mark(coordinates)
  end

  def check_input_for_range(coordinate)
    return true if coordinate > -1 && coordinate < board.row_size
    false
  end

  def check_input_for_mark(coordinates)
    return true if board.find_mark_of_square(coordinates[0],coordinates[1]) == 0
    false
  end

  def run_range_checks(coordinates)
    check_input_for_range(coordinates[0]) && check_input_for_range(coordinates[1])
  end

  def run_exit_check(input)
    exit if ["exit", "quit"].include?(input.downcase)
  end

end

class Game
  attr_accessor :board, :player1, :player2, :current_player
  
  def initialize
    @board=Board.new
    @player1=HumanPlayer.new(board)
    @player2=AiPlayer.new(board)
    @current_player=@player2
  end

  def play_game
    until @board.winner? || @board.tie?
    switch_player
    board.to_s
    @current_player.play_turn
    end
    board.to_s
    puts "Winner!"
  end

  def switch_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

end

Game.new.play_game



