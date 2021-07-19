class Computer

  attr_reader :coordinates_track, :unhit_coordinates

  def initialize
    @unhit_coordinates = Board.new.cells.keys
    @coordinates_track = []
  end

  def place_ship(computer_board, ship)
    spaces = computer_board.cells.keys

    ship_length = ship.length
    result = "Your spaces are invalid.  Please try again:"
    while result.class == String do
      random_coordinate = spaces.sample
      random_direction = [0, 1].sample
      random_coordinate_letter = random_coordinate[0]
      random_coordinate_number = random_coordinate[1]
      coordinates = []
      if random_direction == 0
        counter = 0
        ship_length.times do
          coordinates << random_coordinate_letter + (random_coordinate_number.to_i + counter).to_s
          counter += 1
        end
      else
        counter = 0
        ship_length.times do
          coordinates << (random_coordinate_letter.ord + counter).chr + random_coordinate_number
          counter += 1
        end
      end
      result = computer_board.place(ship, coordinates)
    end
    return computer_board
  end

  def take_turn(player_board)
    coordinate = @unhit_coordinates.sample
    player_board.cells[coordinate].fire_upon
    @unhit_coordinates.delete(coordinate)
    @coordinates_track << coordinate
    player_board
  end


  def display_turn_message(player_board)
    coordinate = @coordinates_track.last
    if player_board.cells[coordinate].ship == nil
      return "The Computer's shot on #{coordinate} was a miss."
    elsif player_board.cells[coordinate].ship.sunk?
      return "The Computer's shot on #{coordinate} sunk your #{player_board.cells[coordinate].ship.name}."
    else
      return "The Computer's shot on #{coordinate} was a hit."
    end
  end
end
