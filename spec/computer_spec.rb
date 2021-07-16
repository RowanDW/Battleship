require "./lib/cell"
require "./lib/board"
require "./lib/computer"
require "./lib/ship"

RSpec.describe Computer do
  context "initialize" do
    it 'exists' do
      player_board = Board.new
      computer = Computer.new(player_board)

      expect(computer).to be_a(Computer)
    end

    it 'has an player board' do
      player_board = Board.new
      computer = Computer.new(player_board)

      expect(computer.player_board).to eq(player_board)
    end

    it 'tracks coordinates have not been used' do
      player_board = Board.new
      computer = Computer.new(player_board)

      expect(computer.unhit_coordinates).to eq(player_board.cells.keys)
    end
  end

  context 'methods' do
    it 'takes a turn randomly' do
      player_board = Board.new
      computer = Computer.new(player_board)

      computer.take_turn
      expect(computer.unhit_coordinates.length).to eq(15)
      expect(computer.player_board.render).not_to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'can determine if all opponent ships have been sunk' do
      player_board = Board.new
      computer = Computer.new(player_board)
      ship = Ship.new("Cruiser", 3)
      ship2 = Ship.new("Submarine", 2)
      player_board.place(ship, ["A1", "A2", "A3"])

      expect(computer.all_player_ships_sunk?).to be false
      16.times do
        computer.take_turn
      end
      expect(computer.all_player_ships_sunk?).to be true
    end
# TODO
    it 'can display turn messages' do
      player_board = Board.new
      computer = Computer.new(player_board)
      ship = Ship.new("Cruiser", 3)
      ship2 = Ship.new("Submarine", 2)
      player_board.place(ship, ["A1", "A2", "A3"])

      computer.take_turn
      expect(computer.display_turn_message).to be_a(String)
    end
  end

end
