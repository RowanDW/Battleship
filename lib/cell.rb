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
    if !empty? && !fired_upon? && show_ship
      return "S"
    elsif !empty? && !fired_upon? && !show_ship
      return "."
    elsif !empty? && fired_upon? && !@ship.sunk?
      return "H"
    elsif !empty?  && fired_upon? && @ship.sunk?
      return "X"
    elsif empty? && fired_upon?
      return "M"
    else
      return "."
    end
  end

end
