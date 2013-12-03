require_relative "spec_helper"
require "debugger"

describe "NegamaxAi" do
  let(:board) {Board.new}
  let(:negamax_player1) {NegamaxAi.new(board, X)}
  let(:negamax_player2) {NegamaxAi.new(board, O)}

  it "should return 1 if next move wins" do
    board.board=[[X,X,N],[N,N,N], [N,N,N]]
    expect(negamax_player1.check_for_optimal_move(X)).to eq 1
  end

  it "should return -1 if next move loses" do
    board.board=[[O,O,N],[N,N,N],[N,N,N]]
    expect(negamax_player1.check_for_optimal_move(X)).to eq -1
  end

  it "should return 0 if next move is a tie" do
    board.board=[[O,X,O],[X,O,X],[X,O,N]]
    expect(negamax_player1.check_for_optimal_move(X)).to eq 0
  end

  it "should return something if there are no moves" do
    board.board=[[N,N,N],[N,N,N],[N,N,N]]
    expect(negamax_player1.check_for_optimal_move(X)).to_not be nil
  end

end