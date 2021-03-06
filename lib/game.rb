require_relative "board"
require_relative "board_view"

class Game
  attr_accessor :board, :player1, :player2, :current_player, :delay, :view

  def initialize(board,player1,player2,currentplayer)
    @board = board
    @delay = 0
    @view = BoardView.new(@board)
    @player1 = player1
    @player2 = player2
    @currentplayer=currentplayer
  end

  def play_game
    until @board.winner? || @board.tie?
    sleep(delay)
    @view.print_board
    @current_player.play_turn
    switch_player
    end
    @view.print_board
    print_winner_message
  end

  def advance_turn
    @current_player.turn += 1
  end

  def switch_player
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  private

  def print_winner_message
    puts "\n"
    if @board.winner?
      puts "Player 1 Wins!" if @current_player == @player2
      puts "Player 2 Wins!" if @current_player == @player1
      puts "Sorry Dave, I can't let you win" if @current_player == @player1 && @player2.class == HardAi
    elsif @board.tie? && @player1.class == HardAi && @player2.class == HardAi
      puts "A strange game. The only winning move is not to play.\nHow about a nice game of chess?"
    else
      puts "Cats game!"
    end
    # ask_to_play
  end

  def ask_to_play
    puts "Would you like to play again [Y] or [N]?"
    play_again=gets.chomp.downcase
    case play_again
      when "y"
        @board.clear_squares
        play_game
      when "n"
        exit
      else
        ask_to_play
    end
  end

end

