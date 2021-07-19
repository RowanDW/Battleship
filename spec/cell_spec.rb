require "./lib/ship"
require "./lib/cell"

RSpec.describe Cell do
  context "cells and coordinates" do
    it "exists" do
      cell = Cell.new("B4")

      expect(cell).to be_an_instance_of(Cell)
    end

    it "shows coordinate" do
      cell = Cell.new("B4")

      expect(cell.coordinate).to eq("B4")
    end

    it "has a ship" do
      cell = Cell.new("B4")

      expect(cell.ship).to eq(nil)
    end

    it "starts out not fired upon" do
      cell = Cell.new("B4")

      expect(cell.fired_upon).to eq(false)
    end
  end

  context "check and place ship" do

    it "has empty?" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)

      expect(cell.empty?).to eq(true)

      cell.place_ship(cruiser)

      expect(cell.empty?).to eq(false)
    end

    it "places a ship" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.ship).to eq(cruiser)
    end
  end

  context "actions" do
    it "has fired upon?" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq(false)
      cell.fire_upon
      expect(cell.fired_upon?).to eq(true)
    end

    it "has fire upon" do
      cell = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      cell.place_ship(cruiser)

      expect(cell.fired_upon?).to eq(false)

      cell.fire_upon

      expect(cell.fired_upon?).to eq(true)
      expect(cell.ship.health).to eq(2)
    end
  end

  context "render" do
    it "can render its states" do
      cell_1 = Cell.new("B4")
      cruiser = Ship.new("Cruiser", 3)
      #cell.place_ship(cruiser)

      expect(cell_1.render).to eq(".")

      cell_1.fire_upon
      expect(cell_1.render).to eq("M")

      cell_1.place_ship(cruiser)
      expect(cell_1.render).to eq("H")

      cell_2 = Cell.new("C3")
      ship = Ship.new("Tiny", 1)

      cell_2.place_ship(ship)

      expect(cell_2.render(true)).to eq("S")

      cell_2.fire_upon

      expect(cell_2.render).to eq("X")
    end
  end
end
