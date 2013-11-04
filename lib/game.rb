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
    puts "Cats!" if @board_tie
    if @board.winner?
      puts "The Human Won!" if @current_player == @player2
      puts "Sorry Dave, I can't let you win" if @current_player == @player1
    else
      puts "Cats!"
    end
  end
  
  def switch_player
    @current_player.turn += 1
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  # def choose_first_player
  #   puts "Would you like the [H]uman to start first, or the [C]omputer, or just [W]atch?"
  #   player_choice=gets.chomp.downcase
  #   if player_choice == "h"
  #     @current_player=@player1 
  #   elsif player_choice == "c"
  #     @current_player=@player2
  #   elsif player_choice == "w"
  #     @player1 = AiPlayer.new(board,self)
  #     @current_player=@player2 
  #   else 
  #     puts "Sorry I need a [C] or [H] or [W]"
  #     choose_first_player
  #   end
  # end

end

