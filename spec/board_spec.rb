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

# def horizontal_line?
#   @board.each do |row| 
#     return true if row.inject(:+) == 3 || row.inject(:+) == -3
#   end
#   false
# end

def horizontal_line?
  @board.any? {|row| check_row(row)}
end

def check_row(row)
  if row.inject(:+) == 3 || row.inject(:+) == -3
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

def check_for_full_board
  return true if !@board.include(0)
end

private 

def to_s
    @board.each do |row|
      print "\n"
      row.each do |space|
        print "|"
        print "---".green if space == 0
        print " X ".red if space == 1
        print " O ".red if space == -1
        print "|"
      end
    end
end

end


describe Board do
  
 let(:board) {Board.new}
  
  it "creates a board" do
    expect(board).to_not be_nil
  end

  it "creates a board of 3 rows and 9 squares by default" do
    expect(board.board.size).to eq(3)
    expect(board.board[0].size).to eq(3)
    expect(board.board.flatten.size).to eq(9)
  end

   it "can create a board of 4 rows and 16 squares" do
    board2=Board.new(4)
    expect(board2.board.size).to eq(4)
    expect(board2.board[0].size).to eq(4)
    expect(board2.board.flatten.size).to eq(16)
  end

  it "initializes all cells to 0" do
    expect(board.board.flatten.uniq).to eq([0])
  end
  
  it "retrieves the value of a cell" do
    expect(board.find_mark_of_square(0,0)).to eq(0)
  end

  it "marks a square and retrieves that value" do
    board.mark_square(1,1,1)
    expect(board.find_mark_of_square(1,1)).to eq(1)
  end

  # it "can reset the board" do
  #   board.mark_square(1,1,2)
  #   expect(board.board.flatten.uniq).to_not eq([0])
  #   board.clear_squares
  #   expect(board.board.flatten.uniq).to eq([0])
  # end

  describe "it returns false if there is no winner" do
    it "returns false if there is no winner" do 
      expect(board.winner?).to eq(false)
    end
  end

  describe "it checks for a horizontal winner" do
    
    it "returns true if the top row is filled" do
      board.board=[[1,1,1],[0,0,0],[0,0,0]]
      expect(board.winner?).to eq(true)
    end
    
    it "returns true if the middle row is filled" do
      board.board=[[0,0,0], [-1,-1,-1], [0,0,0]]
      expect(board.winner?).to eq(true)
    end

    it "returns true if the bottom row is filled" do
      board.board=[[0,0,0], [0,0,0], [1,1,1]] 
      expect(board.winner?).to eq(true)
    end
  end

  describe "it checks for a vertical winner" do 

    it "returns true if left column is filled" do
      board.board=[[-1,0,0], [-1,0,0], [-1,0,0]] 
      expect(board.winner?).to eq(true)
    end

    it "returns true if the middle column is filled" do
      board.board=[[0,1,0], [0,1,0], [0,1,0]] 
      expect(board.winner?).to eq(true)
    end

    it "returns true if the right column is filled" do
      board.board=[[0,0,-1], [0,0,-1], [0,0,-1]] 
      expect(board.winner?).to eq(true)
    end
  end

  describe "it checks for a diagonal winner" do
    it "returns true if the upper left-lower right diagonal is filled" do
      board.board=[[1,0,0],[0,1,0],[0,0,1]]
      expect(board.winner?).to eq true
    end

    it "returns true if the upper right-lower left diagonal is filled" do
      board.board=[[0,0,-1],[0,-1,0],[-1,0,0]]
      expect(board.winner?).to eq true
    end

  end

end