class Board
  require 'colorize'
  attr_reader :row_size
  attr_accessor :board  #needed for quicker testing but we never assign board values this way

  def initialize(row_size=3)
    @row_size = row_size
    @board = Array.new( @row_size ) { Array.new( @row_size, 0 ) }
  end

  def mark_square( board_location, player_marker )
    @board[board_location.row][board_location.column] = player_marker
  end
  
  def find_mark_of_square( board_location )
    @board[board_location.row][board_location.column]
  end
  
  def clear_squares
    (0...@row_size).each do |row|
      (0...@row_size).each do |column|
        boardlocation=BoardLocation.new(row,column)
        mark_square(boardlocation,0)
      end
    end
  end 

def winner?
  return true if check_for_horizontal_winner
  return true if check_for_vertical_winner
  return true if check_for_diagonal_winner
  false
end

def check_for_horizontal_winner
  @board.each do |row|
    return true if row.uniq==[1] || row.uniq==[2]
  end
  false
end

def check_for_vertical_winner
end

def check_for_diagonal_winner
end

def check_for_full_board
end

private 

def to_s
    @board.each do |row|
      print "\n"
      row.each do |space|
        print "|"
        print "---".green if space == 0
        print " X ".red if space == 1
        print " O ".red if space == 2
        print "|"
      end
    end
end

end

BoardLocation = Struct.new(:row, :column)

describe Board do
  
 let(:board) {Board.new}
 let(:board_location) {BoardLocation.new(1,1)}
  
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
    expect(board.find_mark_of_square(board_location)).to eq(0)
  end

  it "marks a square and retrieves that value" do
    board.mark_square(board_location,1)
    expect(board.find_mark_of_square(board_location)).to eq(1)
  end

  it "can reset the board" do
    board.mark_square(board_location,1)
    expect(board.board.flatten.uniq).to_not eq([0])
    board.clear_squares
    expect(board.board.flatten.uniq).to eq([0])
  end

  describe "it checks for a horizontal winner" do
    it "returns false if there is no winner" do 
      expect(board.check_for_horizontal_winner).to eq(false)
    end
    
    it "returns true if the top row is filled" do
      board.board=[[1,1,1],[0,0,0],[0,0,0]]
      expect(board.check_for_horizontal_winner).to eq(true)
    end
    
    it "returns true if the middle row is filled" do
      board.board=[[0,0,0], [1,1,1], [0,0,0]]
      expect(board.check_for_horizontal_winner).to eq(true)
    end

    it "returns true if the bottom row is filled" do
      board.board=[[0,0,0], [0,0,0], [1,1,1]] 
      expect(board.check_for_horizontal_winner).to eq(true)
    end
  end

  describe "it checks for a vertical winner" do 
    it "returns false if there is no winner" do
      expect(board.check_for_vertical_winner).to eq(false)
    end
  end

end