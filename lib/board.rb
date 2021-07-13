class Board

  attr_reader :ship, :board

  def initialize
    @board = board
   end

  def valid_placement?(ship_name, coordinate)
    ship_1 = Ship.new(name, length)
    ship_2 = Ship.new(name, length)
    ship_1.length == 3 && ship_2.length == 2
  end

end
