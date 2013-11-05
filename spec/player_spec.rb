require_relative 'spec_helper'

describe "Player" do
  let (:board) {Board.new}
  let (:player) {HumanPlayer.new(board,1)}

  it "should be able to mark a square" do
    player.mark_space([0,0],1)
    expect(board.find_mark_of_square(0,0)).to eq(1)
  end

  it "should be able to check if a move is out of bounds" do
    expect(player.check_inputs([-1,1])).to eq false
    expect(player.check_inputs([3,3])).to eq false
  end

  it "should be able to check if a space has been played" do
    player.mark_space([1,1],1)
    expect(player.check_inputs([1,1])).to eq false
  end

end
