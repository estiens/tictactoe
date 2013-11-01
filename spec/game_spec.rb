require 'spec_helper'

describe Game do
let (:game) {Game.new}

it "should switch players" do
  game.current_player=game.player1
  game.switch_player
  expect(game.current_player).to eq(game.player2)
end

end