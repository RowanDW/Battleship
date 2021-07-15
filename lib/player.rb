

class Player

  attr_reader :opponent_board, :coordinates_track
  def initialize(opponent_board)
    @opponent_board = opponent_board
    @coordinates_track = []
  end

  def take_turn(coordinate)
    if @coordinates_track.include?(coordinate) == true
      return "You have already entered this coordinate. Try again:"
    elsif @opponent_board.valid_coordinate?(coordinate) == false
      return "This is an invalid coordinate. Try again:"
    else
      @opponent_board.cells[coordinate].fire_upon
      @coordinates_track << coordinate
      @opponent_board.render
    end
  end

  def all_opponent_ships_sunk?
    unsunk_ships = @opponent_board.cells.find do |cell|
      cell.ship != nil && cell.fired_upon? == false
    end
    if unsunk_ships.length > 0
      return false
    else
      return true
    end
  end


end
