require "./lib/ship"
require "./lib/cell"


RSpec.describe Cell do
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
    # ship.new

    expect(cell.ship).to eq(nil)
  end

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

  it "has fired upon?" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    expect(cell.fired_upon?).to eq(false)
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

  it "can render its states" do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    #cell.place_ship(cruiser)

    expect(cell.render).to eq(".")


    cell.fire_upon
    expect(cell.render).to eq("M")

    cell.place_ship(cruiser)
    expect(cell.render).to eq("H")

    cell2 = Cell.new("C3")
    ship = Ship.new("Tiny", 1)

    cell2.place_ship(ship)
    expect(cell2.render(true)).to eq("S")
    cell2.fire_upon
    expect(cell2.render).to eq("X")
  end

end
