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

    if @ship != nil
      @ship.hit
    end
    @fired_upon = true
  end

  def render(show_ship = false)
    if !fired_upon? && show_ship == false
      return "."
    elsif !fired_upon && show_ship == true && empty? == false
      return "S"
    elsif @ship == nil
      return "M"
    elsif @ship.sunk?
      return "X"
    else
      return "H"
    end



  end

end
