require_relative "spec_helper"

describe "MediumAi" do

  let (:board) {Board.new}
  let (:mediumplayer) {MediumAi.new(board,X)}

  it "should be able to make a valid move" do
    mediumplayer.play_turn
    expect(board.board.flatten).to include(1)
  end

  it "should play a middle square for first turn if it isn't taken" do
    mediumplayer.play_turn
    expect(board.find_mark_of_square(1,1)).to eq 1
  end

  it "should play a corner square for first turn if middle is taken" do
    board.mark_square(1,1,-1)
    mediumplayer.play_turn
    expect(board.find_mark_of_square(0,0)+board.find_mark_of_square(2,0)+board.find_mark_of_square(0,2)+board.find_mark_of_square(2,2)).to eq 1
  end

  it "should be able to win horizontally" do
    board.mark_square(0,0,1)
    board.mark_square(0,1,1)
    mediumplayer.play_turn
    expect(board.find_mark_of_square(0,2)).to eq 1
  end

  it "should be able to win vertically" do
    board.mark_square(0,0,1)
    board.mark_square(1,0,1)
    mediumplayer.play_turn
    expect(board.find_mark_of_square(2,0)).to eq 1
  end

  it "should be able to win diagonally" do
    board.mark_square(0,0,1)
    board.mark_square(1,1,1)
    mediumplayer.play_turn
    expect(board.find_mark_of_square(2,2)).to eq 1
  end

  it "should block a win horizontally" do
    board.mark_square(0,0,-1)
    board.mark_square(0,1,-1)
    mediumplayer.play_turn
    expect(board.find_mark_of_square(0,2)).to eq 1
  end

  it "should block a win vertically" do
    board.mark_square(0,0,-1)
    board.mark_square(1,0,-1)
    mediumplayer.play_turn
    expect(board.find_mark_of_square(2,0)).to eq 1
  end

  it "should block a win diagonally" do
    board.mark_square(0,0,-1)
    board.mark_square(1,1,-1)
    mediumplayer.play_turn
    expect(board.find_mark_of_square(2,2)).to eq 1
  end
end
