class Computer

  attr_reader :coordinates_track, :unhit_coordinates

  def initialize
    @unhit_coordinates = Board.new.cells.keys
    @coordinates_track = []
  end

  def place_ship(computer_board, ship)
    spaces = computer_board.cells.keys

    coordinates = []
    result = "Your spaces are invalid.  Please try again:"
    until result != "Your spaces are invalid.  Please try again:" do
      random_coordinate = spaces.sample
      random_direction = [0, 1].sample
      random_coordinate_letter = random_coordinate[0]
      random_coordinate_number = random_coordinate[1]

      if random_direction == 0
        counter = 0
        ship.length.times do
          coordinates << random_coordinate_letter + (random_coordinate_number.to_i + counter).to_s
          counter += 1
        end
      else
        counter = 0
        ship.length.times do
          coordinates << (random_coordinate_letter.ord + counter).to_s + random_coordinate_number
          counter += 1
        end
      end
      result = computer_board.place(ship, coordinates)
    end
    #require 'pry'; binding.pry
    puts computer_board.render
  end

  def take_turn(player_board)
    coordinate = @unhit_coordinates.sample
    player_board.cells[coordinate].fire_upon
    @unhit_coordinates.delete(coordinate)
    @coordinates_track << coordinate
    return player_board
  end

  def all_player_ships_sunk?(player_board)
    unsunk_ships = []
     player_board.cells.each do |coordinate ,cell|
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

  def display_turn_message(player_board)
    coordinate = @coordinates_track.last
    if player_board.cells[coordinate].ship == nil
      return "The Computer's shot on #{coordinate} was a miss."
    elsif player_board.cells[coordinate].ship.sunk? == true
      return "The Computer's shot on #{coordinate} sunk your #{player_board.cells[coordinate].ship.name}."
    else
      return "The Computer's shot on #{coordinate} was a hit."
    end
  end
end
