require_relative 'player'

class AiPlayer < Player

attr_reader :board, :mark_value, :coordinates, :game, :opposing_mark_value
attr_accessor :turn

  def initialize(board,game,mark_value=-1)
    @board=board
    @game=game
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
    elsif check_for_self_fork
      mark_space(check_for_self_fork)
    elsif check_for_opponent_fork
      puts "There was a fork possible"
      mark_space(check_for_opponent_fork)
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

  def check_for_opponent_fork
    forkable_space=[]
    winner=[]
    @board.all_valid_moves.each do |valid_move|
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

  def check_for_fork
    if ((@board.find_mark_of_square(0,0)==@opposing_mark_value && @board.find_mark_of_square(2,2)==@opposing_mark_value))
      return [0,2] if board.empty?(0,2)
      return [2,0] if board.empty?(2,0)
    elsif ((@board.find_mark_of_square(0,2)==@opposing_mark_value && @board.find_mark_of_square(2,0)==@opposing_mark_value))
    end
  end
  # # If it's a unique winning case where the user can get two possible winning spaces
  #   # Check if the user has one move on two corners in any diagonal
  #   if ((@board[:a1] == @user && @board[:c3] == @user) || (@board[:a3] == @user && @board[:c1] == @user)) && @board[:b2] == @cpu && who == "user"
  #     # Decide move
  #     if @board[:a2] == " " && @board[:c2] == " "
  #       pos = rand() > 0.5 ? 7 : 3
  #     elsif @board[:a2] == " "
  #       pos = 7
  #     elsif @board[:c2] == " "
  #       pos = 3
  #     end
  #   end

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
