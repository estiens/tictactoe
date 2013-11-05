require_relative '../player.rb'

class AiPlayer < Player

attr_reader :board, :mark_value, :opposing_mark_value
attr_accessor :turn, :coordinates

  def initialize(board,mark_value=-1)
    @board=board
    @mark_value=mark_value
    @opposing_mark_value = -@mark_value
    @coordinates=[]
    @turn=0
  end

  def play_turn
    if check_for_winner(@mark_value)
      mark_space(check_for_winner(@mark_value))
    elsif check_for_winner(@opposing_mark_value)
      mark_space(check_for_winner(@opposing_mark_value))
    elsif check_for_two_way_fork && check_inputs(check_for_two_way_fork)
      mark_space(check_for_two_way_fork) 
    elsif @turn == 0 
      play_first_turn
    elsif check_for_fork(@opposing_mark_value)
      mark_space(check_for_fork(@opposing_mark_value))
    elsif check_for_fork(@mark_value)
      mark_space(check_for_fork(@mark_value))
    elsif check_inputs(get_middle) 
      mark_space(get_middle)
    else
      play_random_move
    end
  end

  private

  def play_first_turn
    if check_inputs(get_middle)
      mark_space(get_middle)
    else
      play_corner
    end
  end

  def play_corner
    @coordinates=get_corner
    if check_inputs(@coordinates)
        mark_space(@coordinates)
      else
        play_corner
    end
  end

  def play_random_move
    @coordinates=random_value
    if check_inputs(@coordinates)
      mark_space(@coordinates)
    else
      play_random_move
    end
  end

  def check_for_winner(mark_value)
    winner=[]
    @board.all_valid_moves.each do |valid_move|
      @board.mark_square(valid_move[0],valid_move[1],mark_value)
      winner << valid_move if @board.winner?
      @board.mark_square(valid_move[0],valid_move[1],0)
      break if !winner.empty?
    end
    return winner[0] if !winner.empty?
    return false if winner.empty?
  end

  def check_for_two_way_fork
    if (@board.find_mark_of_square(0,0) == @opposing_mark_value) && (@board.find_mark_of_square(2,2) == @opposing_mark_value) && (@board.find_mark_of_square(1,1) == @mark_value)
      return [0,1]
    elsif (@board.find_mark_of_square(0,2) == @opposing_mark_value) && (@board.find_mark_of_square(2,0) == @opposing_mark_value) && (@board.find_mark_of_square(1,1) == @mark_value)
      return [2,1]
    elsif (@board.find_mark_of_square(0,0) == @opposing_mark_value) && (@board.find_mark_of_square(1,1) == @opposing_mark_value) && (@board.find_mark_of_square(2,2) == @mark_value)
      return [0,2]
    else
      return false
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

  def get_corner
    corners=[[0,0],[0,@board.row_size-1],[@board.row_size-1, 0], [@board.row_size-1,@board.row_size-1]]
    corners[rand(4)]
  end

  def get_middle
    [(@board.row_size/2), (@board.row_size/2)]
  end

  def random_value
    [rand(@board.row_size), rand(@board.row_size)]
  end

  def mark_space(coordinates)
    @board.mark_square(coordinates[0],coordinates[1],@mark_value)
  end

end
