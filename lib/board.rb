require 'debugger'

class Board
  require 'colorize'
  attr_reader :row_size
  attr_accessor :board  #needed for quicker testing but we never assign board values this way

  def initialize(row_size=3)
    @row_size = row_size
    @board = Array.new( @row_size ) { Array.new( @row_size, 0 ) }
  end

  def mark_square( row, column, player_marker )
    @board[row][column] = player_marker
  end
  
  def find_mark_of_square( row, column )
    @board[row][column]
  end
  
  def clear_squares
    (0...@row_size).each do |row|
      (0...@row_size).each do |column|
        mark_square([row][column],0)
      end
    end
  end 

  def winner?
    horizontal_line? || vertical_line? || left_diagonal_line? || right_diagonal_line?
  end

  def tie?
    return true if !@board.flatten.include?(0) && !self.winner?
    false
  end

  def to_s
      @board.each_with_index do |row,row_index|
        print "\n"
        print "Row #{row_index}   "
        row.each do |space|
          print "|"
          print "---".green if space == 0
          print " X ".red if space == 1
          print " O ".red if space == -1
          print "|  "
        end
      end
      print "\n          0      1      2   Columns"
  end

private

  def horizontal_line?
    @board.any? {|row| check_row(row)}
  end

  def check_row(row)
    if row.inject(:+) == row.size || row.inject(:+) == -row.size
      return true
    else
      return false
    end
  end

  def vertical_line?
    turned_board=@board[0].zip(@board[1],@board[2])
    turned_board.any? {|row| check_row(row)}
  end

  def left_diagonal_line? #can we refactor this to not use sum and use inject?
    sum = 0
    @board.each_with_index do |row,index|
      sum += row[index]
    end
    return true if sum == 3 || sum == -3
    false
  end

  def right_diagonal_line?
    sum=0
    @board.each_with_index do |row,index|
      sum += row[(row.length-1)-index]
    end
    return true if sum == 3 || sum == -3
    false
  end

  

end