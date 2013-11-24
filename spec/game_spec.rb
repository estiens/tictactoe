require_relative 'spec_helper'

describe Game do
let (:game) {Game.new}
let (:player1) {HardAi.new(game.board)}
let (:player2) {HardAi.new(game.board)}

  it "should switch players" do
    game.player1=player1
    game.player2=player2
    game.current_player=player1
    game.switch_player
    expect(game.current_player).to eq(player2)
  end

  # it "should advance the turn of a player after playing" do
  #   game.player1=player1
  #   game.player2=player2
  #   game.current_player=player1
  #   game.advance_turn
  #   expect(player1.turn).to eq(1)
  # end

end