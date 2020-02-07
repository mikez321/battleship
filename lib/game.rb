require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def initialize
    @player_board = Board.new
    @computer_board = Board.new
    @cruiser = Ship.new("Crusier", 3)
    @submarine = Ship.new("Submarine", 2)
    @start_option = " "
  end

  def welcome
    p "Welcome to BATTLESHIP! \n" +
      "Enter p to play. Enter q to quit"

      @start_option = gets.chomp.downcase
  end

  def setup
    if @start_option == "p"
      p "Geat! Lets play!"

      p "==============PLAYER BOARD=============="
      p @player_board.render(true)

      p "=============COMPUTER BOARD============="
      p @computer_board.render
    else @start_option == "q"
      p "Boo, you suck!"
    end
  end
end
