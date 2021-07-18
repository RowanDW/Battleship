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

    result = "Your spaces are invalid. Please try again:"
    while result == "Your spaces are invalid. Please try again:" do
      input = gets.chomp.split(" ")
      result = @player_board.place(cruiser, input)
      if result == "Your spaces are invalid. Please try again:"
        puts result
      end
    end

    puts @player_board.render(true)

    puts "Enter the squares for the Submarine (2 spaces):"

    result = "Your spaces are invalid. Please try again:"
    while result == "Your spaces are invalid. Please try again:" do
      input = gets.chomp.split(" ")
      result = @player_board.place(submarine, input)
      if result == "Your spaces are invalid. Please try again:"
        puts result
      end
    end

    puts @player_board.render(true)
    return @player_board
  end

  def place_computer_ships

    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    @computer_board = @computer.place_ship(@computer_board, submarine)
    @computer_board = @computer.place_ship(@computer_board, cruiser)
    return @computer_board
  end

  def start
    main_menu
    #place_player_ships
    place_computer_ships
    require 'pry'; binding.pry
    while @player.all_opponent_ships_sunk?(@computer_board) == false && @computer.all_player_ships_sunk?(@player_board) == false do
      puts " "
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render(true)
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true)

      puts "Enter the coordinate for your shot:"
      result = ""
      input = ''
      while result.class == String do
        input = gets.chomp
        result = @player.take_turn(input, @computer_board)
        if result.class == String
          puts result
        end
      end

      @player_board = @computer.take_turn(@player_board)

       puts ""
       puts @player.display_turn_message(input, @computer_board)
       puts @computer.display_turn_message(@player_board)
    end
    puts endgame
  end

  def endgame
    if @player.all_opponent_ships_sunk?(@computer_board) == true && @computer.all_player_ships_sunk?(@player_board) == false
      return "Player wins!"
    else
      return "Computer wins!"
    end
  end
end
