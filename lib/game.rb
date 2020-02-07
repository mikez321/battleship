require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Crusier", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @coputer_cruiser = Ship.new("Crusier", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  def start
    puts "Welcome to BATTLESHIP!"
    puts "Enter p to play. Enter q to quit"
    start_option = gets.chomp

    if start_option == "p"
      puts "Geat! Lets play!"

      puts "==============PLAYER BOARD=============="
      puts @player_board.render
      player_place_ships
    else
      puts  "Boo, you suck!"
    end
  end

  def player_place_ships
    puts "Your ships are: "
    puts "The #{@player_cruiser.name} which will take up #{@player_cruiser.length} spaces."
    puts "The #{@player_submarine.name} which will take up #{@player_submarine.length} spaces."
    puts "\nYou must place your ships on the board.  Spaces must be consecutive\nand obviously the ships have to be fully on the board."
    puts "Enter the coordinates of where you want to place the #{@player_submarine.name}:"
    print "> "
    ship1_coordinates = gets.chomp.delete(" ").split(",")
    if @player_board.valid_placement?(@player_submarine, ship1_coordinates) && ship1_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      ship1_coordinates.each do |coord|
        @player_board.cells[coord].place_ship(@player_submarine)
      end
      puts "Your board now looks like this:"
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true)
    else
      puts "Enter new coordinates, the ones you entered are invalid."
    end

  end


end
