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

end

