require "./lib/ship"
require "./lib/cell"
require "./lib/board"

RSpec.describe Board do
  context "states" do
    it "exists" do
      board = Board.new

      expect(board).to be_an_instance_of(Board)
    end

    it "has cells" do
      board = Board.new

      expect(board.cells.keys).to eq(["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4", "D1", "D2", "D3", "D4"])
    end
  end

  context "behaviors" do
    it "has valid coordinates" do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to eq(true)
      expect(board.valid_coordinate?("D4")).to eq(true)
      expect(board.valid_coordinate?("A5")).to eq(false)
      expect(board.valid_coordinate?("E1")).to eq(false)
      expect(board.valid_coordinate?("A22")).to eq(false)
    end

    it "has valid placement" do
      board = Board.new

      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to eq(false)
      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to eq(false)
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to eq(false)
      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to eq(false)
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to eq(false)
      expect(board.valid_placement?(submarine, ["A1", "A2"])).to eq(true)
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to eq(true)
    end

    it "has coordinates in the same row" do
      board = Board.new

      # cruiser = Ship.new("Cruiser", 3)
      # submarine = Ship.new("Submarine", 2)

      expect(board.all_in_same_row(["A1", "A2", "A3"])).to eq(true)
      expect(board.all_in_same_row(["A2", "A3"])).to eq(true)
      expect(board.all_in_same_row(["A1", "A2", "B4"])).to eq(false)
      expect(board.all_in_same_row(["A1", "C1"])).to eq(false)
      expect(board.all_in_same_row(["A3", "A2", "A1"])).to eq(true)
    end

    it "has coordinates in the same row with consecutive numbers" do
      board = Board.new

      # cruiser = Ship.new("Cruiser", 3)
      # submarine = Ship.new("Submarine", 2)

      expect(board.all_in_same_row_consecutive(["A1", "A2", "A3"])).to eq(true)
      expect(board.all_in_same_row_consecutive(["A2", "A3"])).to eq(true)
      expect(board.all_in_same_row_consecutive(["A1", "A2", "B4"])).to eq(false)
      expect(board.all_in_same_row_consecutive(["A1", "C1"])).to eq(false)
      # Need to come back and adjust
      expect(board.all_in_same_row_consecutive(["A3", "A2", "A1"])).to eq(false)
    end


    it "has coordinates in the same column" do
      board = Board.new

      # cruiser = Ship.new("Cruiser", 3)
      # submarine = Ship.new("Submarine", 2)

      expect(board.all_in_same_column(["A1", "B1", "C1"])).to eq(true)
      expect(board.all_in_same_column(["B2", "C2"])).to eq(true)
      expect(board.all_in_same_column(["A1", "C1", "B4"])).to eq(false)
      expect(board.all_in_same_column(["A1", "C2"])).to eq(false)
      expect(board.all_in_same_column(["A3", "A2", "A1"])).to eq(false)
    end

    it "has coordinates in the same COLUMN with consecutive chars" do
      board = Board.new

      # cruiser = Ship.new("Cruiser", 3)
      # submarine = Ship.new("Submarine", 2)

      expect(board.all_in_same_column_consecutive(["A1", "B1", "C1"])).to eq(true)
      expect(board.all_in_same_column_consecutive(["A2", "B2"])).to eq(true)
      expect(board.all_in_same_column_consecutive(["A1", "A2", "B4"])).to eq(false)
      expect(board.all_in_same_column_consecutive(["A1", "C1"])).to eq(false)
      # Need to come back and adjust
      expect(board.all_in_same_column_consecutive(["C2", "B2", "A2"])).to eq(false)
    end



  end

end
