require './lib/ship'
require './lib/cell'
require './lib/board'
<<<<<<< HEAD
require 'io/console'
=======
require './lib/game_play'
>>>>>>> 63b40caf29c2020e5b5a60d6f42b49576e4a568d

class Game
  attr_reader :player_board, :player_cruiser, :player_submarine,
              :computer_board, :computer_cruiser, :computer_submarine
  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Crusier", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Crusier", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @game_over = false
  end

<<<<<<< HEAD
  def start_banner
    puts " _______  _______  _______  _______  ___      _______  _______  __   __  ___   _______ "
    puts "|  _    ||   _   ||       ||       ||   |    |       ||       ||  | |  ||   | |       |"
    puts "| |_|   ||  |_|  ||_     _||_     _||   |    |    ___||  _____||  |_|  ||   | |    _  |"
    puts "|       ||       |  |   |    |   |  |   |    |   |___ | |_____ |       ||   | |   |_| |"
    puts "|  _   | |       |  |   |    |   |  |   |___ |    ___||_____  ||       ||   | |    ___|"
    puts "| |_|   ||   _   |  |   |    |   |  |       ||   |___  _____| ||   _   ||   | |   |    "
    puts "|_______||__| |__|  |___|    |___|  |_______||_______||_______||__| |__||___| |___|    "
    puts "\n"
  end

  def start
    system "clear"
    start_banner
    puts "Enter p to play. Enter q to quit"
    start_option = gets.chomp.downcase
      until start_option == "p" || start_option == "q"
        system "clear"
        start_banner
        puts "Enter p to play. Enter q to quit"
        start_option = gets.chomp
      end
    if start_option == "p"
      puts "Geat! Lets play!"
      place_computer_ships
      place_player_ships_prompt
    elsif start_option == "q"
      system "clear"
      puts  "Come back when you're ready for battle!"
    end
  end
=======
>>>>>>> 63b40caf29c2020e5b5a60d6f42b49576e4a568d

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

<<<<<<< HEAD
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
=======
  def place_player_shot(coordinate)
    # require "pry"; binding.pry
    until @computer_board.valid_coordinate?(coordinate) && !@computer_board.cells[coordinate].fired_upon?
        puts "Invalid coordinates, please try again."
        puts ">"
        coordinate = gets.chomp
    end
    @computer_board.cells[coordinate].fire_upon

    if @computer_board.cells[coordinate].render == "M"
      puts "Your shot on #{coordinate} was a miss!"
    elsif @computer_board.cells[coordinate].render == "H"
      puts "Your shot on #{coordinate} was a hit!"
    elsif @computer_board.cells[coordinate].render == "X"
      puts "Your shot on #{coordinate} sunk a ship!"
    end

    if @computer_cruiser.sunk? && @computer_submarine.sunk?
      @game_play.game_over = true
    end
  end

  def place_computer_shot
    coordinate = @player_board.cells.keys.sample
    until @player_board.valid_coordinate?(coordinate) && !@player_board.cells[coordinate].fired_upon?
      coordinate = @player_board.cells.keys.sample
    end
    @player_board.cells[coordinate].fire_upon

    if @player_board.cells[coordinate].render == "M"
      puts "Their shot on #{coordinate} was a miss!"
    elsif @player_board.cells[coordinate].render == "H"
      puts "Their shot on #{coordinate} was a hit!"
    elsif @player_board.cells[coordinate].render == "X"
      puts "Their shot on #{coordinate} sunk your ship!"
    end

    if @player_cruiser.sunk? && @player_submarine.sunk?
      @game_play.game_over = true
    end
  end

  def game_over_message
    if @player_cruiser.sunk? && @player_submarine.sunk?
      p "HA, You lost! Try again!"
    else @computer_cruiser.sunk? && @computer_submarine.sunk?
      p "I want a rematch!"
    end
>>>>>>> 63b40caf29c2020e5b5a60d6f42b49576e4a568d
  end
end
