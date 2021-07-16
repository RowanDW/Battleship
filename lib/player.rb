class Player

  attr_reader :coordinates_track

  def initialize
    @coordinates_track = []
  end

  def take_turn(coordinate, opponent_board)
    if @coordinates_track.include?(coordinate) == true
      return "You have already entered this coordinate. Try again:"
    elsif opponent_board.valid_coordinate?(coordinate) == false
      return "This is an invalid coordinate. Try again:"
    else
      opponent_board.cells[coordinate].fire_upon
      @coordinates_track << coordinate
      return opponent_board
    end
  end

  def all_opponent_ships_sunk?(opponent_board)
    unsunk_ships = []
     opponent_board.cells.each do |coordinate ,cell|
      if cell.ship != nil && cell.fired_upon? == false
        unsunk_ships << cell
      end
    end
    if unsunk_ships.count > 0
      return false
    else
      return true
    end
  end

  def display_turn_message(coordinate, opponent_board)
    if opponent_board.cells[coordinate].ship == nil
      return "Your shot on #{coordinate} was a miss."
    elsif opponent_board.cells[coordinate].ship.sunk? == true
      return "Your shot on #{coordinate} sunk their #{opponent_board.cells[coordinate].ship.name}."
    else
      return "Your shot on #{coordinate} was a hit."
    end
  end
end
