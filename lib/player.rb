class Player

  def mark_space(coordinates)
    @board.mark_square(coordinates[0], coordinates[1], mark_value )
  end

  def check_inputs(coordinates)
    run_range_checks(coordinates) && check_input_for_mark(coordinates)
  end

  def check_input_for_range(coordinate)
    return true if coordinate > -1 && coordinate < board.row_size
    false
  end

  def check_input_for_mark(coordinates) 
    return true if board.find_mark_of_square(coordinates[0],coordinates[1]) == 0
    false
  end

  def run_range_checks(coordinates)
    check_input_for_range(coordinates[0]) && check_input_for_range(coordinates[1])
  end

  def run_exit_check(input)
    exit if ["exit", "quit"].include?(input.downcase)
  end
  
end