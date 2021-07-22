class Computer

  attr_reader :coordinates_track, :unhit_coordinates

  def initialize(height = 4, width = 4)
    @unhit_coordinates = Board.new(height, width).cells.keys
    @coordinates_track = []
    @target_coordinates = []
    @board_height = height
    @board_width = width
  end

  def get_random_coordinate
    spaces = Board.new(@board_height, @board_width).cells.keys
    spaces.sample
  end

  def get_random_direction
    [0, 1].sample
  end

  def place_ship(computer_board, ship)
    ship_length = ship.length
    result = "Your spaces are invalid.  Please try again:"
    while result.class == String do
      random_coordinate = get_random_coordinate
      random_direction = get_random_direction
      random_coordinate_letter = random_coordinate[0]
      if @board_width < 10
        random_coordinate_number = random_coordinate[1]
      else
        random_coordinate_number = random_coordinate[1,2]
      end
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

  def get_random_unhit_coordinates
    @unhit_coordinates.sample
  end

  def get_surrounding_coordinates(coordinate, board)
    coordinate_letter = coordinate[0]
    if coordinate.length == 2
      coordinate_number = coordinate[1]
    else
      coordinate_number = coordinate[1,2]
    end
    coordinates = []
    coordinates << coordinate_letter + (coordinate_number.to_i + 1).to_s
    coordinates << coordinate_letter + (coordinate_number.to_i - 1).to_s
    coordinates << (coordinate_letter.ord + 1).chr + coordinate_number
    coordinates << (coordinate_letter.ord - 1).chr + coordinate_number
    all_valid = coordinates.filter do |coord|
      board.valid_coordinate?(coord)
    end
    #require 'pry'; binding.pry
    all_valid
  end

  def all_surrounding_hit?(coordinate, board)
    coordinate_letter = coordinate[0]
    if coordinate.length == 2
      coordinate_number = coordinate[1]
    else
      coordinate_number = coordinate[1,2]
    end
    coordinates = []
    coordinates << coordinate_letter + (coordinate_number.to_i + 1).to_s
    coordinates << coordinate_letter + (coordinate_number.to_i - 1).to_s
    coordinates << (coordinate_letter.ord + 1).chr + coordinate_number
    coordinates << (coordinate_letter.ord - 1).chr + coordinate_number
    all_valid_coords = coordinates.filter do |coord|
      board.valid_coordinate?(coord)
    end
    all_valid_coords.each do |coord|
      if board.cells[coord].fired_upon? == false
        return false
      end
    end
    return true
  end

  def take_turn(player_board)
    targets = []
    @target_coordinates.each do |coord|
      if all_surrounding_hit?(coord, player_board)
        @target_coordinates.delete(coord)
      elsif player_board.cells[coord].ship.sunk? == false
        targets << coord
      end
    end
    target = targets.last
    #require 'pry'; binding.pry
    if target != nil
      surrounding = get_surrounding_coordinates(target, player_board)
      smart_coordinates = []
      surrounding.each do |coord|
        if !@coordinates_track.include?(coord)
          smart_coordinates << coord
        end
      end
      coordinate = smart_coordinates.first
    else
      #require 'pry'; binding.pry
      coordinate = get_random_unhit_coordinates
    end
    player_board.cells[coordinate].fire_upon
    @unhit_coordinates.delete(coordinate)
    @coordinates_track << coordinate
    if player_board.cells[coordinate].ship != nil
      @target_coordinates << coordinate
    end

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
