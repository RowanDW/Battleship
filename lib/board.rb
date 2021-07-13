class Board

  attr_reader :board, :cells

  def initialize
    @board = board
    @cells = create_board
  end

  def create_board
    board_hash = {}
    alphabet = ["A", "B", "C", "D"]
    row_count = 0
    4.times do
      column_count = 1
      4.times do
        coordinate = alphabet[row_count] + column_count.to_s
        board_hash[coordinate] = Cell.new(coordinate)
        column_count += 1
      end
      row_count += 1
    end
    board_hash
  end

  def valid_coordinate?(coordinate)
    @cells.has_key?(coordinate)
  end

  # def valid_placement?(ship, coordinate)
  #   if ship.length != coordinate.length
  #     false
  #   # elsif coordinate.find do |item|
  #
  # end

    



  end

end
