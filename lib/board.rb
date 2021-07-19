class Board

  attr_reader :cells

  def initialize
    @cells = create_board
  end

  def create_board
    board_hash = {}
    alphabet = ["A", "B", "C", "D"]
    numbers = ["1", "2", "3", "4"]
    alphabet.each do |letter|
      numbers.each do |num|
        coordinate = letter + num
        board_hash[coordinate] = Cell.new(coordinate)
      end
    end
    board_hash
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    not_all_valid = coordinates.any? do |coordinate|
      valid_coordinate?(coordinate) == false
    end

    if ship.length != coordinates.length || overlapping?(coordinates) || not_all_valid
      false
    elsif all_in_same_row_consecutive?(coordinates) || all_in_same_column_consecutive?(coordinates)
      true
    else
      false
    end
  end

  def all_in_same_row?(coordinates)
    first_letter = coordinates[0][0]
    coordinates.all? do |item|
      item[0] == first_letter
    end
  end

  def all_in_same_row_consecutive?(coordinate)
    range = 1..4
    array = range.to_a

    if all_in_same_row?(coordinate) == false
      return false
    end

    valid_coordinate = []

    array.each_cons(coordinate.count) do |item|
      valid_coordinate << item
    end

    actual_coordinate = []
    coordinate.each do |item|
      actual_coordinate << item[1].to_i
    end

    valid_coordinate.include?(actual_coordinate)
  end

  def all_in_same_column?(coordinate)
    same_number = coordinate[0][1]
    coordinate.each do |item|
      if item[1] != same_number
        return false
      end
    end
    true
  end

  def all_in_same_column_consecutive?(coordinate)
    range = "A".."D"
    array = range.to_a

    if all_in_same_column?(coordinate) == false
      return false
    end

    valid_coordinate = []

    array.each_cons(coordinate.count) do |item|
      valid_coordinate << item
    end

    actual_coordinate = []
    coordinate.each do |item|
      actual_coordinate << item[0]
    end

    valid_coordinate.include?(actual_coordinate)
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates) == true
      coordinates.each do |coordinate|
        @cells[coordinate].place_ship(ship)
      end
    else
      return "Your spaces are invalid. Please try again:"
    end
  end

  def overlapping?(coordinates)
    coordinates.each do |coordinate|
      if @cells[coordinate].ship != nil
        return true
      end
    end
    false
  end

  def render(ship = false)
    strings = "  1 2 3 4 \n"
    alphabet = ["A", "B", "C", "D"]
    numbers = ["1", "2", "3", "4"]
    alphabet.each do |letter|
      strings = strings + letter+ " "
      numbers.each do |number|
        coordinate = letter + number
        strings = strings + @cells[coordinate].render(ship) + " "
      end
      strings = strings + "\n"
    end
    return strings
  end
end
