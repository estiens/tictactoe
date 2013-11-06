class MediumAi < AiPlayer

  def play_turn
    if check_for_winner(@mark_value)
      mark_space(check_for_winner(@mark_value))
    elsif check_for_winner(@opposing_mark_value)
      mark_space(check_for_winner(@opposing_mark_value))
    elsif @turn == 0
      play_first_turn
    else
      play_random_move
    end
  end

end