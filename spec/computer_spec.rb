require "./lib/cell"
require "./lib/board"
require "./lib/computer"
require "./lib/ship"

RSpec.describe Computer do
  context "initialize" do
    it 'exists' do
      computer = Computer.new

      expect(computer).to be_a(Computer)
    end

    it 'keeps track of all used coordinates' do
      computer = Computer.new

      expect(computer.coordinates_track).to eq([])
    end

    it 'tracks coordinates have not been used' do
      computer = Computer.new
      board = Board.new

      expect(computer.unhit_coordinates).to eq(board.cells.keys)
    end
  end

  context 'methods' do
    it 'takes a turn randomly' do
      board = Board.new
      computer = Computer.new

      board = computer.take_turn(board)
      expect(computer.unhit_coordinates.length).to eq(15)
      expect(board.render).not_to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    end

    it 'can determine if all opponent ships have been sunk' do
      board = Board.new
      computer = Computer.new
      ship = Ship.new("Cruiser", 3)
      ship2 = Ship.new("Submarine", 2)
      board.place(ship, ["A1", "A2", "A3"])

      expect(computer.all_player_ships_sunk?(board)).to be false
      16.times do
        board = computer.take_turn(board)
      end
      expect(computer.all_player_ships_sunk?(board)).to be true
    end

    it "can randomly place ships" do
      computer_board = Board.new
      computer = Computer.new
      #ship = Ship.new("Cruiser", 3)
      ship2 = Ship.new("Submarine", 2)

      expect(computer.place_ship(computer_board, ship2).render).not_to eq(computer_board.render(true))
    end

# TODO
    it 'can display turn messages' do
      board = Board.new
      computer = Computer.new
      ship = Ship.new("Cruiser", 3)
      ship2 = Ship.new("Submarine", 2)
      board.place(ship, ["A1", "A2", "A3"])

      board = computer.take_turn(board)
      expect(computer.display_turn_message(board)).to be_a(String)
    end
  end

end
