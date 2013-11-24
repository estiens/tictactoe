class NegamaxAi < Player

  def initialize(board,mark_value=X)
    @board=board
    @mark_value=mark_value
    @opposing_mark_value = -@mark_value
    @coordinates=[]
  end

def play_turn
end

def negamax(board,player,depth)
  if board.winner? || board.tie?
    return value(board, player)
  else
    best_rank = -999
    opponent = opponent(player)
    board.available_spaces.each do |space|
    board.place_mark(space,player)
    depth += 1
    rank = -negamax(board,opponent)
    board.undo(space)
    if rank > best_rank
      best_rank = rank
      # best_move = space if depth == 1
    end
  end
  return best_rank
end
end


def value(board, player)
  if board.winner == player
    return 1
  elsif board.winner == opponent(player)
    return -1
  else
    return 0
  end
end

def opponent(marker) marker == "X" ? "O" : "X"
end


end

def check_for_fork(mark_value)
    forkable_space=[]
    winner=[]
    @board.all_valid_moves.each do |valid_move|
      winner.clear
      @board.mark_square(valid_move[0],valid_move[1],mark_value)
      forkable_space=[valid_move[0],valid_move[1]]
      @board.all_valid_moves.each do |second_move|
        @board.mark_square(second_move[0],second_move[1],mark_value)
        winner << second_move if @board.winner?
        @board.mark_square(second_move[0],second_move[1],0)
        break if winner.length > 1
      end
      @board.mark_square(valid_move[0],valid_move[1],0)
      break if winner.length>1
    end
    return forkable_space if winner.length > 1
    return false if winner.length <= 1
  end