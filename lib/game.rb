require_relative "human_player"
require_relative "ai_player"
require_relative "board"

class Game
  attr_accessor :board, :player1, :player2, :current_player, :turn
  
  def initialize
    @board =   Board.new
    @player1 = HumanPlayer.new(board)
    @player2 = AiPlayer.new(board,self)
    @turn =    0
  end

  def play_game
    choose_first_player
    until @board.winner? || @board.tie?
    board.to_s
    @current_player.play_turn
    switch_player
    end
    board.to_s
    puts "Winner! is #{@board.winner}"
  end
  
  def switch_player
    @current_player.turn += 1
    @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
  end

  def choose_first_player
    puts "Would you like the [H]uman to start first, or the [C]omputer"
    player_choice=gets.chomp.downcase
    if player_choice == "h"
      @current_player=@player1 
    elsif player_choice == "c"
      @current_player=@player2 
    else 
      puts "Sorry I need a [C] or [H]"
      choose_first_player
    end
  end

end

