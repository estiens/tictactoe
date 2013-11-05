require_relative "board"

class Game
  attr_accessor :board, :player1, :player2, :current_player, :delay

  def initialize
    @board = Board.new
    @delay = 0
  end

  def play_game
    until @board.winner? || @board.tie?
    sleep(delay)
    board.to_s
    @current_player.play_turn
    switch_player
    end
    board.to_s
    print_winner_message
  end
  
  def switch_player
    @current_player.turn += 1
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def print_winner_message
    puts "\n\n"
    if @board.winner?
      puts "The Human Won!" if @current_player == @player2
      puts "Sorry Dave, I can't let you win" if @current_player == @player1
    elsif @board.tie? && @player1.class == AiPlayer && @player2.class == AiPlayer
      puts "A strange game. The only winning move is not to play.\nHow about a nice game of chess?"
    else 
      puts "Cats game!"
    end
    ask_to_play
  end

  def ask_to_play
    puts "Would you like to play again [Y] or [N]?"
    play_again=gets.chomp.downcase
    if play_again == "y"
      @board.clear_squares
      play_game
    elsif play_again == "n"
      exit
    else
      ask_to_play
    end
  end

end

