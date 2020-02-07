require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Crusier", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Crusier", 3)
    @computer_submarine = Ship.new("Submarine", 2)
  end

  def start
    puts "Welcome to BATTLESHIP!"
    puts "Enter p to play. Enter q to quit"
    start_option = gets.chomp

    if start_option == "p"
      puts "Geat! Lets play!"
      place_computer_submarine
      place_computer_cruiser
      place_player_ships
    else
      puts  "Come back when you're ready for battle!"
    end
  end

  def place_computer_submarine
    rand_coordinates = []
    until @computer_board.valid_placement?(@computer_submarine, rand_coordinates)
      rand_coordinates = []
      @computer_submarine.length.times do
        rand_coordinates << @computer_board.cells.keys.shuffle.first
      end
    end
    @computer_board.place(@computer_submarine, rand_coordinates)
  end

  def place_computer_cruiser
    rand_coordinates = []
      until @computer_board.valid_placement?(@computer_cruiser, rand_coordinates)
        rand_coordinates = []
        @computer_cruiser.length.times do
          rand_coordinates << @computer_board.cells.keys.shuffle.first
        end
      end
      @computer_board.place(@computer_cruiser, rand_coordinates)
  end

  def place_player_ships
    system "clear"
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "I have laid out my boats on my board."
    puts "Now it is your turn."
    puts "Your ships are: "
    puts "The #{@player_cruiser.name.upcase} which will take up #{@player_cruiser.length} spaces."
    puts "The #{@player_submarine.name.upcase} which will take up #{@player_submarine.length} spaces."
    puts "\nYou must place your ships on the board.  Spaces must be consecutive\nand obviously the ships have to be fully on the board."
    puts "Are you ready to place your ship? Press y when ready."
    response = gets.chomp.downcase
    if response == "y"
      player_place_submarine
    else
      "OK.  Let me know when you're ready by pressing Y."
    end
  end

  def normalize_input_coordinates(coordinates)
    coordinates.split(" ").map do |coordinate|
      coordinate.delete(" ").delete(",").upcase
      end
  end

  def player_place_submarine
    puts "Enter the coordinates of where you want to place the #{@player_submarine.name}"
    puts "The #{@player_submarine.name} will take up #{@player_submarine.length} spaces:"
    print "> "
    submarine_coordinates = gets.chomp
    user_coordinates = normalize_input_coordinates(submarine_coordinates)
    until @player_board.valid_placement?(@player_submarine, user_coordinates) && user_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      puts "Enter new coordinates, the ones you entered are invalid."
      submarine_coordinates = gets.chomp
      user_coordinates = normalize_input_coordinates(submarine_coordinates)
    end
    user_coordinates.each do |coordinate|
      @player_board.cells[coordinate].place_ship(@player_submarine)
    end
    player_place_cruiser
  end

  def player_place_cruiser
    puts "Now place your #{@player_cruiser.name} which will take up #{@player_cruiser.length} spaces."
    print "> "
    cruiser_coordinates = gets.chomp
    cruiser_coordinates = normalize_input_coordinates(cruiser_coordinates)
    until @player_board.valid_placement?(@player_cruiser, cruiser_coordinates) && cruiser_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      puts "Enter new coordinates, the ones you entered are invalid."
      cruiser_coordinates = gets.chomp
      user_coordinates = normalize_input_coordinates(cruiser_coordinates)
    end

    cruiser_coordinates.each do |coord|
      @player_board.cells[coord].place_ship(@player_cruiser)
    end
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render(true)
    puts "Here is your board with your ships:"
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
    puts "Ready to play?  Press S to start"
    puts "> "
    start_option = gets.chomp.downcase

  end
end
