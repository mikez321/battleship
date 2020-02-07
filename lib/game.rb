require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def initialize
    @board = Board.new
    @cruiser = Ship.new("Crusier", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def start
    puts "Welcome to BATTLESHIP!"
    puts "Enter p to play. Enter q to quit"
    start_option = gets.chomp

    if start_option == "p"
      puts "Geat! Lets play!"

      puts "==============PLAYER BOARD=============="
      puts @board.render
      place_ships
    else
      puts  "Boo, you suck!"
    end
  end

  def place_ships
    puts "Your ships are: "
    puts "The #{@cruiser.name} which will take up #{@cruiser.length} spaces."
    puts "The #{@submarine.name} which will take up #{@submarine.length} spaces."
    puts "\nYou must place your ships on the board.  Spaces must be consecutive\nand obviously the ships have to be fully on the board."
    puts "Enter the coordinates of where you want to place the #{@submarine.name}:"
    print "> "
    ship1_coordinates = gets.chomp
    if
      @board.valid_placement?(@submarine, ship1_coordinates.delete(" ").split(","))
      ship1_coordinates.split(",").each do |coord|
        @board.cells[coord.delete(" ")].place_ship(@submarine)
      end
    else
      "Enter new coordinates, the ones you entered are invalid."
    end
    puts "Your board now looks like this:"
    puts "==============PLAYER BOARD=============="
    puts @board.render(true)

  end


end
