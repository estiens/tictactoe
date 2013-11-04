require_relative "game"
require_relative "human_player"
require_relative "./ai_players/ai_player"
require_relative "./ai_players/medium_ai"
require_relative "./ai_players/dumb_ai"


class Runner
  attr_reader :game

  def initialize
    @game = Game.new
  end

  def run_game
    choose_first_player
    @game.play_game
  end

  private

  def choose_first_player
    puts "Would you like the [H]uman to start first, or the [C]omputer, or just [W]atch?"
    player_choice=gets.chomp.downcase
    if player_choice == "h"
      @game.player1=HumanPlayer.new(@game.board)
      @game.current_player=@game.player1
      choose_difficulty
    elsif player_choice == "c"
      @game.player1=HumanPlayer.new(@game.board)
      choose_difficulty
      @game.current_player=@game.player2 
    elsif player_choice == "w"
      @game.player1 = AiPlayer.new(@game.board,1)
      @game.player2 = AiPlayer.new(@game.board,-1)
      @game.delay=0.5
      @game.current_player=@game.player1
    else 
      puts "Sorry I need a [C] or [H] or [W]"
      choose_first_player
    end
  end

  def choose_difficulty
    puts "Would you like to play against a [E]asy Opponent, a [M]edium Opponent, or a [H]ard Opponent"
    difficulty_choice=gets.chomp.downcase
    if difficulty_choice == "e"
      @game.player2=DumbAi.new(@game.board)
    elsif difficulty_choice == "m"
      @game.player2=MediumAi.new(@game.board)
    elsif difficulty_choice == "h"
      @game.player2=AiPlayer.new(@game.board)
    else
      choose_difficulty
    end
  end


end

Runner.new.run_game