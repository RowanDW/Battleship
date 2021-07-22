class Player

  attr_reader :coordinates_track

  def initialize
    @coordinates_track = []
  end

  def take_turn(coordinate, opponent_board)
    if @coordinates_track.include?(coordinate)
      return "You have already entered this coordinate. Try again:"
    elsif !opponent_board.valid_coordinate?(coordinate)
      return "This is an invalid coordinate. Try again:"
    else
      opponent_board.cells[coordinate].fire_upon
      @coordinates_track << coordinate
      opponent_board
    end
  end

  def display_turn_message(coordinate, opponent_board)
    if opponent_board.cells[coordinate].ship == nil
      return "Your shot on #{coordinate} was a miss."
    elsif opponent_board.cells[coordinate].ship.sunk?
      return "Your shot on #{coordinate} sunk their #{opponent_board.cells[coordinate].ship.name}."
    else
      return "Your shot on #{coordinate} was a hit."
    end
  end
end
