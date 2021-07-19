require "./lib/ship"

RSpec.describe Ship do
  context "attributes" do
    it "exists" do
      ship = Ship.new("Cruiser", 3)

      expect(ship).to be_an_instance_of(Ship)
    end

    it "has a name" do
      ship = Ship.new("Cruiser", 3)

      expect(ship.name).to eq("Cruiser")
    end

    it "has a length" do
      ship = Ship.new("Cruiser", 3)

      expect(ship.length).to eq(3)
    end

    it "starts with health equal to length" do
      ship = Ship.new("Cruiser", 3)

      expect(ship.health).to eq(3)
    end
  end

  context "actions" do
    it "sinks" do
      ship = Ship.new("Cruiser", 3)

      expect(ship.sunk?).to eq(false)

      ship.hit
      ship.hit

      expect(ship.sunk?).to eq(false)

      ship.hit

      expect(ship.sunk?).to eq(true)
    end

    it "hits" do
      ship = Ship.new("Cruiser", 3)
      ship.hit

      expect(ship.health).to eq(2)
    end
  end
end
