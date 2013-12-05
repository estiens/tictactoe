require_relative 'spec_helper'

describe "GameRunner" do
    let(:runner) {Runner.new}

    it "should initialize a new game" do
        runner.initialize_game

        expect(runner.game).to be_a_kind_of Game
    end

    it "should initialize a game with an opponent of the proper difficulty level when Easy is selected" do
        allow(runner.parser).to receive(:get_difficulty_level).and_return("E")

        runner.initialize_game

        expect(runner.game.player1).to be_a_kind_of HumanPlayer
        expect(runner.game.player2).to be_a_kind_of EasyAi
    end

    it "should initialize a game with an opponent of the proper difficulty level when Medium is selected" do
        allow(runner.parser).to receive(:get_difficulty_level).and_return("M")

        runner.initialize_game

        expect(runner.game.player1).to be_a_kind_of HumanPlayer
        expect(runner.game.player2).to be_a_kind_of MediumAi
    end

    it "should initialize a game with an opponent of the proper difficulty level when Hard is selected" do
        allow(runner.parser).to receive(:get_difficulty_level).and_return("H")

        runner.initialize_game

        expect(runner.game.player1).to be_a_kind_of HumanPlayer
        expect(runner.game.player2).to be_a_kind_of HardAi
    end

    it "should set the current player correctly" do
        pending
    end

end