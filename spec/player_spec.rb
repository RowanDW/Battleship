require "./lib/cell"
require "./lib/board"
require "./lib/player"
require "./lib/ship"

RSpec.describe Player do
  context "initialize" do
    it 'exists' do
      opponent_board = Board.new
      player = Player.new(opponent_board)

      expect(player).to be_a(Player)
    end

    it 'has an opponent board' do
      opponent_board = Board.new
      player = Player.new(opponent_board)

      expect(player.opponent_board).to eq(opponent_board)
    end

    it 'tracks coordinates already used' do
      opponent_board = Board.new
      player = Player.new(opponent_board)

      expect(player.coordinates_track).to eq([])
    end
  end

  context 'methods' do
    it 'has an opponent board' do
      opponent_board = Board.new
      player = Player.new(opponent_board)

      player.take_turn("A1")
      expect(player.coordinates_track).to eq(["A1"])
      expect(player.opponent_board.render).to eq("  1 2 3 4 \nA M . . . \nB . . . . \nC . . . . \nD . . . . \n")

      expect(player.take_turn("A1")).to eq("You have already entered this coordinate. Try again:")
      expect(player.take_turn("Z1")).to eq("This is an invalid coordinate. Try again:")
    end
  end

end
