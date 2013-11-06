require_relative 'ai_player'

class DumbAi < AiPlayer

  def play_turn
    play_random_move
  end

end