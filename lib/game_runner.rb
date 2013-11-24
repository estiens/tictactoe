require_relative "game"
require_relative "human_player"
require_relative "./ai_players/hard_ai"
require_relative "./ai_players/medium_ai"
require_relative "./ai_players/dumb_ai"
require_relative "./ai_players/negamax_ai"

X = 1
O = -1
N = 0

class Runner
  attr_reader :game

  def initialize
    @game = Game.new
  end

  def run_game
    choose_first_player
    @game.play_game
  end

  def simulate_games(simulation_times=1000) #comment out #ask_to_play in game.print_winner_message if you want to simulate games
    game_results=Hash.new(0)
    simulation_times.times do
      game = Game.new
      game.player1 = HardAi.new(game.board,1)
      game.player2 = HardAi.new(game.board,-1)
      game.current_player = game.player1
      game.play_game
      if game.board.tie?
        game_results["tie"] += 1
      elsif game.board.winner?
        game_results["#{game.player1.class} - X"] += 1 if game.current_player == game.player2
        game_results["#{game.player2.class} - 0"] += 1 if game.current_player == game.player1
      end
    end
    puts game_results
  end

  private

  def choose_first_player
    puts "Would you like the [H]uman to start first, or the [C]omputer, or just [W]atch?"
    player_choice=gets.chomp.downcase
    case player_choice
      when "h"
        @game.player1 = HumanPlayer.new(@game.board)
        @game.current_player = @game.player1
        choose_difficulty
      when "c"
        @game.player1 = HumanPlayer.new(@game.board)
        choose_difficulty
        @game.current_player=@game.player2
      when "w"
        @game.player1 = HardAi.new(@game.board,1)
        @game.player2 = HardAi.new(@game.board,-1)
        @game.delay = 0.5
        @game.current_player = @game.player1
      else
        puts "Sorry, I need a [C] or [H] or [W]"
        choose_first_player
    end
  end

  def choose_difficulty
    puts "Would you like to play against an\n[E]asy Opponent, a [M]edium Opponent, or a [H]ard Opponent"
    difficulty_choice=gets.chomp.downcase
    case difficulty_choice
      when "e"
        @game.player2 = DumbAi.new(@game.board)
      when "m"
        @game.player2 = MediumAi.new(@game.board)
      when "h"
        @game.player2 = HardAi.new(@game.board)
      else
        puts "Sorry, I need an [E], [M], or [H]"
        choose_difficulty
    end
  end

end

# runner=Runner.new
# runner.simulate_games



