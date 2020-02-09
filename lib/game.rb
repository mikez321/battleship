require './lib/ship'
require './lib/cell'
require './lib/board'
require 'io/console'

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
      place_computer_ships
      place_player_ships_prompt
    else
      system "clear"
      puts  "Come back when you're ready for battle!"
    end
  end

  def place_computer_ships
    computer_ships = [@computer_submarine, @computer_cruiser]
    computer_ships.each do |ship|
      rand_coordinates = []
      until @computer_board.valid_placement?(ship, rand_coordinates)
        rand_coordinates = []
        ship.length.times do
          rand_coordinates << @computer_board.cells.keys.shuffle.first
        end
      end
      @computer_board.place(ship, rand_coordinates)
    end
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

  def header
    puts "=============* BATTLESHIP *============="
    puts "\n\n"
  end

  def place_player_ships_prompt
    system "clear"
    display_board("computer")
    puts "\nI have laid out my ship on my board and am ready for battle!"
    puts "\nNow it is your turn."
    puts "Your ships are: "
    puts "The #{@player_cruiser.name.upcase} which will take up #{@player_cruiser.length} spaces."
    puts "The #{@player_submarine.name.upcase} which will take up #{@player_submarine.length} spaces."
    puts "\nYou must place your ships on the board."
    puts "Spaces must be consecutive."
    puts "Obviously the ships have to be fully on the board."
    puts "Separate coordinates with a space or comma."
    place_player_ships_actions
  end

  def normalize_input_coordinates(coordinates)
    coordinates.split(" ").map do |coordinate|
      coordinate.delete(" ").delete(",").upcase
      end
  end

  def ship_placer(ship, normalized_coordinates)
    until @player_board.valid_placement?(ship, normalized_coordinates) &&
        normalized_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      puts "Enter new coordinates, the ones you entered are invalid."
      print "> "
      loop_coordinates = gets.chomp
      normalized_coordinates = normalize_input_coordinates(loop_coordinates)
    end
    normalized_coordinates.each do |coordinate|
      @player_board.cells[coordinate].place_ship(ship)
    end
  end

  def place_player_ships_actions
    player_ships = [@player_submarine, @player_cruiser]
    player_ships.each do |ship|
      puts "\nEnter the coordinates of where you want to place the #{ship.name}"
      puts "The #{ship.name} will take up #{ship.length} spaces:"
      print "> "
      ship_coordinates = gets.chomp
      normalized_coordinates = normalize_input_coordinates(ship_coordinates)
      ship_placer(ship, normalized_coordinates)
      puts "\nYour #{ship.name.upcase} has been placed!\n"
    end
    last_setup_screen
  end

  def last_setup_screen
    system "clear"
    header
    puts "My board is ready!"
    display_board("computer")
    print "\n"
    display_board("player")
    puts "Press any key to start\n  "
    STDIN.getch
    get_player_shot
  end

  def get_player_shot
    system "clear"
    header
    display_board("computer")
    print "\n\n"
    display_board("player")
    puts "Hit me with your best shot!"
    print "> "
    coordinate = gets.chomp.upcase
  end
end
