require_relative "spec_helper"
require "debugger"

describe "NegamaxAi" do
  let(:board) {Board.new}
  let(:negamax_player1) {NegamaxAi.new(board, X)}
  let(:negamax_player2) {NegamaxAi.new(board, O)}

  it "should return 1 if it wins" do
    board.board=[[X,X,X],[N,N,N], [N,N,N]]
    expect(negamax_player1.negamax(board,X,1)).to eq 1
  end

  it "should return -1 if it loses" do
  end

  it "should return 0 if it is a tie" do
  end

end