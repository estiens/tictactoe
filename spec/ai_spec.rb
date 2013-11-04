require_relative "spec_helper"

describe "Hard Ai" do
  let (:board) {Board.new}
  let (:hardplayer) {AiPlayer.new(board,1)}
  let (:mediumplayer) {MediumAi.new(board,1)}
  let (:dumbplayer) {DumbAi.new(board,1)}

  it "should be able to make a valid move" do
  hardplayer.play_turn
  expect(board.board.flatten).to include(1)
  end

  it "should play a middle square for first turn if it isn't taken" do
    hardplayer.play_turn
    debugger
    expect(board.find_mark_of_square(1,1)).to eq 1
  end

  it "should play a corner square for first turn if middle is taken" do
    board.mark_square(1,1,-1)
    hardplayer.play_turn
    expect(board.find_mark_of_square(0,0)+board.find_mark_of_square(2,0)+board.find_mark_of_square(0,2)+board.find_mark_of_square(2,2)).to eq 1
  end

  it "should be able to win horizontally" do
    board.mark_square(0,0,1)
    board.mark_square(0,1,1)
    hardplayer.play_turn
    expect(board.find_mark_of_square(0,2)).to eq 1
  end

  it "should be able to win vertically" do
    board.mark_square(0,0,1)
    board.mark_square(1,0,1)
    hardplayer.play_turn
    expect(board.find_mark_of_square(2,0)).to eq 1
  end

  it "should be able to win diagonally" do
    board.mark_square(0,0,1)
    board.mark_square(1,1,1)
    hardplayer.play_turn
    expect(board.find_mark_of_square(2,2)).to eq 1
  end

  it "should block a win horizontally" do
    board.mark_square(0,0,-1)
    board.mark_square(0,1,-1)
    expect(hardplayer.check_for_opponent_winner).to eq [0,2]
  end

  it "should block a win vertically" do
    board.mark_square(0,0,-1)
    board.mark_square(1,0,-1)
    expect(hardplayer.check_for_opponent_winner).to eq [2,0]
  end

  it "should block a win diagonally" do
    board.mark_square(0,0,-1)
    board.mark_square(1,1,-1)
    expect(hardplayer.check_for_opponent_winner).to eq [2,2]
  end

  it "should be able to find a forking opportunity" do
    board.mark_square(0,0,1)
    board.mark_square(2,1,1)
    expect(hardplayer.check_for_self_fork).to eq [2,2] || [1,1]
  end

  it "should be able to block a forking opportunity" do
    board.mark_square(0,0,-1)
    board.mark_square(2,1,-1)
    expect(hardplayer.check_for_opponent_fork).to eq [0,1] || [1,1]
  end

  describe "MediumAi" do
     
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

  it "should be able to find a win horizontally" do
    board.mark_square(0,0,1)
    board.mark_square(0,1,1)
    expect(mediumplayer.check_for_self_winner).to eq [0,2]
  end

  it "should be able to find a win vertically" do
    board.mark_square(0,0,1)
    board.mark_square(1,0,1)
    expect(mediumplayer.check_for_self_winner).to eq [2,0]
  end

  it "should be able to find a win diagonally" do
    board.mark_square(0,0,1)
    board.mark_square(1,1,1)
    expect(mediumplayer.check_for_self_winner).to eq [2,2]
  end

  it "should block a win horizontally" do
    board.mark_square(0,0,-1)
    board.mark_square(0,1,-1)
    expect(mediumplayer.check_for_opponent_winner).to eq [0,2]
  end

  it "should block a win vertically" do
    board.mark_square(0,0,-1)
    board.mark_square(1,0,-1)
    expect(mediumplayer.check_for_opponent_winner).to eq [2,0]
  end

  it "should block a win diagonally" do
    board.mark_square(0,0,-1)
    board.mark_square(1,1,-1)
    expect(mediumplayer.check_for_opponent_winner).to eq [2,2]
  end
  end

  describe "DumbAi" do
  it "should be able to make a valid move" do
      dumbplayer.play_turn
      expect(board.board.flatten).to include(1)
  end
  end


end