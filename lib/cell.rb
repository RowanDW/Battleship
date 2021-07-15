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

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if @ship != nil
      @ship.hit
    end
    @fired_upon = true
  end

  def render(show_ship = false)
    if empty? == false && fired_upon? == false && show_ship == true
      return "S"
    elsif empty? == false && fired_upon? == false && show_ship == false
      return "."
    elsif empty? == false && fired_upon? == true && @ship.sunk? == false
      return "H"
    elsif empty? == false && fired_upon? == true && @ship.sunk? == true
      return "X"
    elsif empty? == true && fired_upon? == true
      return "M"
    else
      return "."
    end
  end

end
