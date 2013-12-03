class NegamaxAi < Player

  def initialize(board,mark_value=X)
    @board=board
    @mark_value=mark_value
    @opposing_mark_value = -@mark_value
    @coordinates=[]
  end

def play_turn
end

# def negamax(board,player,depth)
#   if board.winner? || board.tie?
#     return value(board, player)
#   else
#     best_rank = -999
#     opponent = opponent(player)
#     board.available_spaces.each do |space|
#     board.place_mark(space,player)
#     depth += 1
#     rank = -negamax(board,opponent)
#     board.undo(space)
#     if rank > best_rank
#       best_rank = rank
#       # best_move = space if depth == 1
#     end
#   end
#   return best_rank
#   end
# end


# def value(board, mark_value)
#   if board.who_won == mark_value
#     return 1
#   elsif board.who.won == -mark_value
#     return -1
#   else
#     return 0
#   end
# end

# def opponent(marker) marker == "X" ? "O" : "X"
# end

def check_for_optimal_move(mark_value)
  @board.all_valid_moves.each do |valid_move|
    @board.mark_square(valid_move[0],valid_move[1],mark_value)
    marked_square=[valid_move[0],valid_move[1]]
    if @board.winner?
      return mark_value
    elsif @board.tie?
      return 0
    else
      check_for_optimal_move(mark_value = -mark_value)
    end
  end
end

end