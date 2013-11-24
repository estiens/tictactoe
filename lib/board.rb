class Board
  X = 1
  O = -1
  NONE = 0

  require 'colorize'

  attr_reader :row_size
  attr_accessor :board  #needed for quicker testing but we never assign board values this way

  def initialize(row_size=3)
    @row_size = row_size
    @board = Array.new( @row_size ) { Array.new( @row_size, 0 ) }
  end

  def mark_square(row, column, player_marker)
    @board[row][column] = player_marker
  end

  def find_mark_of_square(row, column)
    @board[row][column]
  end

  def empty?(row,column)
    find_mark_of_square(row,column) == NONE
  end

  def undo(row, column)
    @board[row][column] = NONE
  end

  def clear_squares
    (0...@row_size).each do |row|
      (0...@row_size).each do |column|
        undo(row,column)
      end
    end
  end

  def winner?
    horizontal_line? || vertical_line? || diagonal_lines?
  end

  def tie?
    board_full? && (not self.winner?)
  end

  def all_valid_moves
    valid_moves=[]
    @board.each_with_index do |row, rowindex|
      row.each_with_index do |space, columnindex|
        valid_moves << [rowindex,columnindex] if space == 0
      end
    end
    valid_moves
  end

  def print_board
    space_counter = 1
    print "\n"
      @board.each_with_index do |row,row_index|
        print "\n"
        row.each do |space|
          print "|"
          print "-#{space_counter}-".green if space == NONE
          print " X ".red if space == X
          print " O ".red if space == O
          print "|  "
          space_counter += 1
        end
      end
  end

private

  def board_full?
    not @board.flatten.include?(0)
  end

  def horizontal_line?
    @board.any? {|row| check_row_for_winner(row)}
  end

  def vertical_line?
    turned_board=@board[0].zip(@board[1],@board[2])
    turned_board.any? {|row| check_row_for_winner(row)}
  end

  def diagonal_lines?
    sum_left = 0
    sum_right = 0
    @board.each_with_index do |row,index|
      sum_left += row[index]
      sum_right += row[(row.length-1)-index]
    end
    sum_left == @row_size || sum_left == -@row_size || sum_right == @row_size || sum_right == -@row_size
  end


  def check_row_for_winner(row)
    row.inject(:+) == row.size || row.inject(:+) == -row.size
  end

end