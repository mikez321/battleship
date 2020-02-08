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
      system "clear"
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

  def display_board(player)
    if (player == "computer")
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render
    elsif (player == "player")
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true)
    end
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
    display_board("computer")
    puts "I have laid out my ship on my board and am ready for battle!"
    puts "\nNow it is your turn."
    puts "Your ships are: "
    puts "The #{@player_cruiser.name.upcase} which will take up #{@player_cruiser.length} spaces."
    puts "The #{@player_submarine.name.upcase} which will take up #{@player_submarine.length} spaces."
    puts "\nYou must place your ships on the board."
    puts "Spaces must be consecutive."
    puts "Obviously the ships have to be fully on the board."
    puts "Separate coordinates with a space or comma."
    player_place_submarine
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
      print "> "
      submarine_coordinates = gets.chomp
      user_coordinates = normalize_input_coordinates(submarine_coordinates)
    end
    user_coordinates.each do |coordinate|
      @player_board.cells[coordinate].place_ship(@player_submarine)
    end
    player_place_cruiser
  end

  def player_place_cruiser
    puts "The #{@player_cruiser.name} will take up #{@player_cruiser.length} spaces:"
    print "> "
    cruiser_coordinates = gets.chomp
    user_coordinates = normalize_input_coordinates(cruiser_coordinates)
    until @player_board.valid_placement?(@player_cruiser, user_coordinates) && user_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      puts "Enter new coordinates, the ones you entered are invalid."
      print "> "
      cruiser_coordinates = gets.chomp
      user_coordinates = normalize_input_coordinates(cruiser_coordinates)
    end
    user_coordinates.each do |coordinate|
      @player_board.cells[coordinate].place_ship(@player_cruiser)
    end
    last_setup
  end

  def last_setup
    system "clear"
    puts "My board is ready!"
    display_board("computer")
    print "\n"
    puts "=============* BATTLESHIP *============="
    puts "\nHere is your board with your ships:"
    display_board("player")
    puts "Ready to play?  Press S to start"
    puts "> "
    start_option = gets.chomp.downcase
  end
end
