class Cell

  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship == nil
  end

  def place_ship(ship_name)
    @ship = ship_name
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @ship.hit
    @fired_upon = true
  end

end
