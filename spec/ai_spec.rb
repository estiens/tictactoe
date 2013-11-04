require_relative "spec_helper"

describe "AiPlayers" do
  let (:board) {Board.new}
  let (:gameboard) {board.board}
  let (:hardplayer) {AiPlayer.new(board,1)}

  it "should be able to make a valid move" do
  hardplayer.play_turn
  expect(gameboard.flatten).to include(1)
  end

  it "should be able to find a win horizontally" do
  board.mark_square(0,0,1)
  board.mark_square(0,1,1)
  expect(hardplayer.check_for_self_winner).to eq [0,2]
  end

  it "should be able to find a win diagonally" do
    board.mark_square(0,0,1)
    board.mark_square(1,0,1)
    expect(hardplayer.check_for_self_winner).to eq [2,0]
  end


end