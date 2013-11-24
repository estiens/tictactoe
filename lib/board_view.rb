class BoardView

require 'colorize'

  attr_reader :board

  def initialize(board)
    @board=board.board
  end

  def print_board
    space_counter = 1
    print "\n"
      @board.each_with_index do |row,row_index|
        print "\n"
        row.each do |space|
          print "|"
          print "-#{space_counter}-".green if space == 0
          print " X ".red if space == X
          print " O ".red if space == O
          print "|  "
          space_counter += 1
        end
      end
  end

end