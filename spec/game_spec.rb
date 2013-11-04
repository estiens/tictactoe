require_relative 'spec_helper'

describe Game do
let (:game) {Game.new}
let (:player1) {HumanPlayer.new(game.board)}
let (:player2) {HumanPlayer.new(game.board)}

it "should switch players" do
  game.player1=player1
  game.player2=player2
  game.current_player=player1
  game.switch_player
  expect(game.current_player).to eq(player2)
end

end