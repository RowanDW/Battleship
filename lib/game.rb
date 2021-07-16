class Game

  attr_reader :player_board, :computer_board, :player, :computer

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @player = Player.new
    @computer = Computer.new
  end

  def main_menu
     puts "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit."
     input = gets.chomp
  end

  def place_player_ships
    puts "I have laid out my ships on the grid.\n You now need to lay out your two ships.\n The Cruiser is three units long and the Submarine is two units long."
    puts @player_board.render
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    puts "Enter the squares for the Cruiser (3 spaces):"

    result = "Your spaces are invalid.  Please try again:"
    until result != "Your spaces are invalid.  Please try again:" do
      input = gets.chomp.split(" ")
      result = @player_board.place(cruiser, input)
    end

    puts @player_board.render(true)

    puts "Enter the squares for the Submarine (2 spaces):"

    result = "Your spaces are invalid.  Please try again:"
    until result != "Your spaces are invalid.  Please try again:" do
      input = gets.chomp.split(" ")
      result = @player_board.place(submarine, input)
    end

    puts @player_board.render(true)
  end

  def place_computer_ships
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @computer.place_ship(@computer_board, cruiser)
    @computer.place_ship(@computer_board, submarine)
     return @computer_board
  end

  def start
    main_menu
    @player_board = place_player_ships
    @computer_board = place_computer_ships

    while @player.all_opponent_ships_sunk?(@computer_board) == false && @computer.all_player_ships_sunk?(@player_board) == false do
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render
      puts "==============PLAYER BOARD=============="
      puts @player_board.render

      puts "Enter the coordinate for your shot:"
      result = ""

      until result != String do
        input = gets.chomp
        result = @player.take_turn(input, @computer_board)
      end

      # @computer_board = @player.take_turn(input, @computer_board)
      @player_board = @computer.take_turn(@player_board)

      @player.display_turn_message(input, @computer_board)
      @computer.display_turn_message(@player_board)
    end
    endgame
  end

  def endgame
    if @player.all_opponent_ships_sunk?(@computer_board) == true && @computer.all_player_ships_sunk?(@player_board) == false
      puts "Player wins!"
    elsif @computer.all_player_ships_sunk?(@player_board) == true && @player.all_opponent_ships_sunk?(@computer_board) == false
      puts "Computer wins!"
    else
      puts "It's a tie."
    end
  end
end
