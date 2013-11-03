require_relative 'player'

class AiPlayer < Player

attr_reader :board, :mark_value, :opposing_mark_value
attr_accessor :turn, :coordinates

  def initialize(board,game,mark_value=-1)
    @board=board
    @mark_value=mark_value
    @opposing_mark_value = -@mark_value
    @coordinates=[]
    @turn=0
  end

  def random_value
    [rand(@board.row_size), rand(@board.row_size)]
  end

  def play_turn
    if @turn == 0 
      play_first_and_second_turn
    elsif check_for_self_winner
      mark_space(check_for_self_winner)
    elsif check_for_opponent_winner
      mark_space(check_for_opponent_winner)
    elsif hard_code_for_isolated_cases
      mark_space(hard_code_for_isolated_cases)
    elsif check_for_opponent_fork
      mark_space(check_for_opponent_fork)
    elsif check_for_self_fork
      puts "There was a fork possible"
      mark_space(check_for_self_fork)
    else
      play_random_move
    end
  end

      
  def play_first_and_second_turn
    @coordinates=get_middle
        if check_inputs(@coordinates)
          mark_space(@coordinates)
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
    @coordinates=take_random
    if check_inputs(@coordinates)
      mark_space(@coordinates)
    else
      play_random_move
    end
  end

  def check_for_self_winner
    winner=[]
    @board.all_valid_moves.each do |valid_move|
      previous_value = @board.find_mark_of_square(valid_move[0],valid_move[1])
      @board.mark_square(valid_move[0],valid_move[1],@mark_value)
      winner << valid_move if @board.winner?
      @board.mark_square(valid_move[0],valid_move[1],previous_value)
      break if !winner.empty?
    end
    return winner[0] if !winner.empty?
    return false if winner.empty?
  end

  def check_for_self_fork
    forkable_space=[]
    winner=[]
    @board.all_valid_moves.each do |valid_move|
      previous_value = @board.find_mark_of_square(valid_move[0],valid_move[1])
      @board.mark_square(valid_move[0],valid_move[1],mark_value)
      forkable_space=[valid_move[0],valid_move[1]]
      @board.all_valid_moves.each do |second_move|
        previous_value = @board.find_mark_of_square(second_move[0],second_move[1])
        @board.mark_square(second_move[0],second_move[1],mark_value)
        winner << second_move if @board.winner?
        @board.mark_square(second_move[0],second_move[1],previous_value)
        end
      @board.mark_square(valid_move[0],valid_move[1],previous_value)
    end
    return forkable_space if winner.length > 1
    return false if winner.length <= 1
  end

  def check_for_opponent_fork2
    forkable_space=[]
    winner=[]
    @board.all_valid_moves.each do |valid_move|
      winner=[]
      previous_value = @board.find_mark_of_square(valid_move[0],valid_move[1])
      @board.mark_square(valid_move[0],valid_move[1],@opposing_mark_value)
      forkable_space=[valid_move[0],valid_move[1]]
      @board.all_valid_moves.each do |second_move|
        previous_value = @board.find_mark_of_square(second_move[0],second_move[1])
        @board.mark_square(second_move[0],second_move[1],@opposing_mark_value)
        winner << second_move if @board.winner?
        @board.mark_square(second_move[0],second_move[1],previous_value)
        end
      @board.mark_square(valid_move[0],valid_move[1],previous_value)
    end
    return forkable_space if winner.length > 1
    return false if winner.length <= 1
  end

    def check_for_opponent_fork
    winner=[]
    forkable_space=[]
    @board.all_valid_moves.each do |valid_move|
      winner=[]
      previous_value = @board.find_mark_of_square(valid_move[0],valid_move[1])
      @board.mark_square(valid_move[0],valid_move[1],@opposing_mark_value)
      forkable_space=[valid_move[0],valid_move[1]]
      @board.all_valid_moves.each do |opponent_move|
        previous_opponent_value = @board.find_mark_of_square(opponent_move[0],opponent_move[1])
        @board.mark_square(opponent_move[0],opponent_move[1],@opposing_mark_value)
        @board.all_valid_moves.each do |second_move|
          previous_second_value = @board.find_mark_of_square(second_move[0],second_move[1])
          @board.mark_square(second_move[0],second_move[1],@opposing_mark_value)
          winner << second_move if @board.winner?
          @board.mark_square(second_move[0],second_move[1],previous_second_value)
        break if winner.length>1 
        end
        @board.mark_square(opponent_move[0],opponent_move[1], previous_opponent_value)
        break if winner.length>1
        end
      @board.mark_square(valid_move[0],valid_move[1],previous_value)
      break if winner.length>1
    end
    return forkable_space if winner.length > 1
    return false if winner.length <= 1
  end

  def hard_code_for_isolated_cases
    # these are here because they were the only two forking conditions not being caught by the method. Method should be fixed 
    # and ideally all ported to minimax algorithm

    if (@board.find_mark_of_square(0,0) == @opposing_mark_value) && (@board.find_mark_of_square(2,1) == @opposing_mark_value)
      return [2,0] if check_inputs([2,0])
    elsif (@board.find_mark_of_square(0,2) == @opposing_mark_value) && (@board.find_mark_of_square(2,1) == @opposing_mark_value)
      return [2,2] if check_inputs([2,2])
    else
      return false
    end
  end

  def check_for_opponent_winner
    #if any move results in opponent win, block it
    blocker=[]
    @board.all_valid_moves.each do |valid_move|
      previous_value = @board.find_mark_of_square(valid_move[0],valid_move[1])
      @board.mark_square(valid_move[0],valid_move[1],@opposing_mark_value)
      blocker << valid_move if @board.winner?
      @board.mark_square(valid_move[0],valid_move[1],previous_value)
      break if !blocker.empty?
    end
    return blocker[0] if !blocker.empty?
    return false if blocker.empty?
  end


  def get_corner
    corners=[[0,0],[0,@board.row_size-1],[@board.row_size-1, 0], [@board.row_size-1,@board.row_size-1]]
    corners[rand(4)]
  end

  def get_middle
    [(@board.row_size/2), (@board.row_size/2)]
  end

  def take_random
    random_value
  end

  def mark_space(coordinates,mark_value=@mark_value)
    @board.mark_square(coordinates[0],coordinates[1],@mark_value)
  end

  def analyze(board)
  end

end
