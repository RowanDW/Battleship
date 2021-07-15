class Game

  attr_reader :player_board, :computer_board
  def initialize
    @player_board = Board.new
    @computer_board = Board.new
  end

  def main_menu
    puts "Welcome to BATTLESHIP\n Enter p to play. Enter q to quit."
    # input = gets.chomp
    # if input == "q"
    #   exit
    # elsif input == 'p'
  end

  def setup
    
  end
end
