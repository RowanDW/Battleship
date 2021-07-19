require "./lib/ship"
require "./lib/cell"
require "./lib/board"
require "./lib/game"
require "./lib/player"
require "./lib/computer"

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

    it 'has a computer' do
      game = Game.new

      expect(game.computer).to be_a(Computer)
    end

    it 'has a player' do
      game = Game.new

      expect(game.player).to be_a(Player)
    end

  end

  context "methods" do
    xit 'has a welcome message' do
      game = Game.new

      expect(game.main_menu).to eq("Welcome to BATTLESHIP\n Enter p to play. Enter q to quit.")
    end
    xit 'can determine endgame' do
      game = Game.new
      submarine = Ship.new("Submarine", 2)
      cruiser = Ship.new("Cruiser", 3)
      game.player_board.place(cruiser, ['A1', 'B1', 'C1'])
      game.player_board.place(submarine, ['A2', 'B2'])

      game.computer_board.place(cruiser, ['A1', 'B1', 'C1'])
      game.computer_board.place(submarine, ['A2', 'B2'])

      game.player.take_turn('A1', game.computer_board)
      game.player.take_turn('B1', game.computer_board)
      game.player.take_turn('C1', game.computer_board)
      game.player.take_turn('A2', game.computer_board)
      game.player.take_turn('B2', game.computer_board)
      # game.player.take_turn('A1', game.player_board)
      # game.player.take_turn('B1', game.player_board)
      # game.player.take_turn('C1', game.player_board)
      # game.player.take_turn('A2', game.player_board)
      # game.player.take_turn('B2', game.player_board)
      expect(game.endgame).to eq("Player wins!")
    end

    it 'can determine if all opponent ships have been sunk' do
      game = Game.new
      ship = Ship.new("Cruiser", 3)
      ship2 = Ship.new("Submarine", 2)
      game.computer_board.place(ship, ["A1", "A2", "A3"])

      game.player.take_turn("A1", game.computer_board)
      game.player.take_turn("A2", game.computer_board)
      expect(game.all_ships_sunk?(game.computer_board)).to be false

      game.player.take_turn("A3", game.computer_board)
      expect(game.all_ships_sunk?(game.computer_board)).to be true

      game.computer_board.place(ship2, ["B2", "C2"])

      expect(game.all_ships_sunk?(game.computer_board)).to be false

      game.player.take_turn("B2", game.computer_board)
      game.player.take_turn("C2", game.computer_board)

      expect(game.all_ships_sunk?(game.computer_board)).to be true
    end

  end
end
