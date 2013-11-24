require_relative "spec_helper"

describe "DumbAi" do
  let (:board) {Board.new}
  let (:dumbplayer) {DumbAi.new(board,X)}

  it "should be able to make a valid move" do
      dumbplayer.play_turn
      expect(board.board.flatten).to include(1)
  end
end
