require_relative 'spec_helper'
  X = 1
  O = -1
  N = 0

describe Board do

 let(:board) {Board.new}
 let(:board4) {Board.new(4)}

  it "creates a board" do
    expect(board).to_not be_nil
  end

  it "creates a board of 3 rows and 9 squares by default" do
    expect(board.board.size).to eq(3)
    expect(board.board[0].size).to eq(3)
    expect(board.board.flatten.size).to eq(9)
  end

   it "can create a board of 4 rows and 16 squares" do
    expect(board4.board.size).to eq(4)
    expect(board4.board[0].size).to eq(4)
    expect(board4.board.flatten.size).to eq(16)
  end

  it "initializes all cells to 0" do
    expect(board.board.flatten.uniq).to eq([0])
  end

  it "retrieves the value of a cell" do
    expect(board.find_mark_of_square(0,0)).to eq(0)
  end

  it "marks a square and retrieves that value" do
    board.mark_square(1,1,X)
    expect(board.find_mark_of_square(1,1)).to eq(X)
  end

  it "checks for a tie and returns false when no tie" do
    expect(board.tie?).to eq false
  end

  it "checks for a tie and returns true when there is a tie" do
    board.board=[[X,O,X],[O,X,O],[O,X,O]]
    expect(board.tie?).to eq true
  end

  describe "it returns false if there is no winner" do
    it "returns false if there is no winner" do
      expect(board.winner?).to eq(false)
    end
  end

  describe "it checks for a horizontal winner" do

    it "returns true if the top row is filled" do
      board.board=[[X,X,X],[N,N,N],[N,N,N]]
      expect(board.winner?).to eq(true)
    end

    it "returns true if the middle row is filled" do
      board.board=[[N,N,N], [O,O,O], [N,N,N]]
      expect(board.winner?).to eq(true)
    end

    it "returns true if the bottom row is filled" do
      board.board=[[N,N,N], [N,N,N], [X,X,X]]
      expect(board.winner?).to eq(true)
    end

  end

  describe "it checks for a vertical winner" do

    it "returns true if left column is filled" do
      board.board=[[O,N,N], [O,N,N], [O,N,N]]
      expect(board.winner?).to eq(true)
    end

    it "returns true if the middle column is filled" do
      board.board=[[N,X,N], [N,X,N], [N,X,N]]
      expect(board.winner?).to eq(true)
    end

    it "returns true if the right column is filled" do
      board.board=[[N,N,O], [N,N,O], [N,N,O]]
      expect(board.winner?).to eq(true)
    end

  end

  describe "it checks for a diagonal winner" do

    it "returns true if the upper left-lower right diagonal is filled" do
      board.board=[[X,N,N],[N,X,N],[N,N,X]]
      expect(board.winner?).to eq true
    end

    it "returns true if the upper right-lower left diagonal is filled" do
      board.board=[[N,N,O],[N,O,N],[O,N,N]]
      expect(board.winner?).to eq true
    end

  end

  describe "it passes cursory checks for a 4x4 board" do

    it "returns true if there is a horizontal winner" do
      board4.board=[X,N,N,N],[X,N,N,N],[X,N,N,N],[X,N,N,N]
      expect(board4.winner?).to eq true
    end

    it "returns true if there is a vertical winner" do
      board4.board=[[O,O,O,O],[N,N,N,N],[N,N,N,N],[N,N,N,N]]
      expect(board4.winner?).to eq true
    end

    it "returns true if there is a diagonal winner" do
      board4.board=[[O,N,N,N],[N,O,N,N],[N,N,O,N],[N,N,N,O]]
      expect(board4.winner?).to eq true
    end

  end

  describe "#all valid moves" do
    it "returns all valid moves" do
      expect(board.all_valid_moves).to eq([[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]])
    end

    it "returns all valid moves when some are taken" do
      board.board=[[X,X,X], [O,O,O], [N,N,N]]
      expect(board.all_valid_moves).to eq([[2,0],[2,1],[2,2]])
    end
  end

  describe "#empty" do
    it "returns true when a space is empty" do
      expect(board.empty?(0,0)).to eq true
    end
    it "returns false when a space is not empty" do
      board.mark_square(0,0,X)
      expect(board.empty?(0,0)).to eq false
    end
  end

  describe '#undo' do
    it "resets the selected space to NONE" do
    board.mark_square(1,1,X)
    board.undo(1,1)
    expect(board.find_mark_of_square(1,1)).to eq 0
    end
  end

  describe '#clear_squares' do
    it "clears all the squares on the board" do
      board.mark_square(1,1,1)
      board.mark_square(1,2,O)
      board.clear_squares
      expect(board.board.flatten.uniq).to eq([0])
    end
  end

end

