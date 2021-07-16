class Computer

  attr_reader :player_board, :coordinates_track, :unhit_coordinates
  def initialize(player_board)
    @player_board = player_board
    @unhit_coordinates = player_board.cells.keys
    @coordinates_track = []
  end

  def take_turn
    coordinate = @unhit_coordinates.sample
    @player_board.cells[coordinate].fire_upon
    @unhit_coordinates.delete(coordinate)
    @coordinates_track << coordinate
    return @player_board.render
  end

  def all_player_ships_sunk?
    unsunk_ships = []
     @player_board.cells.each do |coordinate ,cell|
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

  def display_turn_message
    coordinate = @coordinates_track.last
    if @player_board.cells[coordinate].ship == nil
      return "The Computer's shot on #{coordinate} was a miss."
    elsif @player_board.cells[coordinate].ship.sunk? == true
      return "The Computer's shot on #{coordinate} sunk your #{@player_board.cells[coordinate].ship.name}."
    else
      return "The Computer's shot on #{coordinate} was a hit."
    end
  end
end
