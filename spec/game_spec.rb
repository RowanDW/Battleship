require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"

RSpec.describe Game do
  context "initialize" do
    it 'exists' do
      game = Game.new

      expect(game).to be_a(Game)
    end

    it 'has a player board' do
      game = Game.new

      expect(game.player_board).to be_a(Board)
    end

    it 'has a computer board' do
      game = Game.new

      expect(game.computer_board).to be_a(Board)
    end
  end

  context "methods" do
    it 'has a welcome message' do
      game = Game.new

      expect(game.main_menu).to eq("Welcome to BATTLESHIP\n Enter p to play. Enter q to quit.")
    end
  end
end
