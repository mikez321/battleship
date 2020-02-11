require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'

class GamePlay

  def initialize
    @game = Game.new
    @player_board = Board.new
    @player_cruiser = Ship.new("Crusier", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Crusier", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @game_over = false
  end

  def start
    puts "Welcome to BATTLESHIP!"
    puts "Enter p to play. Enter q to quit"
    start_option = gets.chomp

    if start_option == "p"
      puts "Great! Lets play!"
      @game.place_computer_submarine
      @game.place_computer_cruiser
      place_player_ships
    else
      puts  "Come back when you're ready for battle!"
    end
  end

  def place_player_ships
    # system "clear"
    puts "=============COMPUTER BOARD============="
    puts @computer_board.render
    puts "I have laid out my ships on my board."
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

  def player_place_submarine
    puts "Enter the coordinates of where you want to place the #{@player_submarine.name}:"
    print "> "
    submarine_coordinates = gets.chomp.delete(" ").split(",")
    until @player_board.valid_placement?(@player_submarine, submarine_coordinates) && submarine_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      puts "Enter new coordinates, the ones you entered are invalid."
      submarine_coordinates = gets.chomp.delete(" ").split(",")
    end
    submarine_coordinates.each do |coordinate|
      @player_board.cells[coordinate].place_ship(@player_submarine)
    end
    player_place_cruiser
  end

  def player_place_cruiser
    puts "Now place your #{@player_cruiser.name} which will take up #{@player_cruiser.length} spaces."
    print "> "
    cruiser_coordinates = gets.chomp.delete(" ").split(",")
    until @player_board.valid_placement?(@player_cruiser, cruiser_coordinates) && cruiser_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      puts "Enter new coordinates, the ones you entered are invalid."
      cruiser_coordinates = gets.chomp.delete(" ").split(",")
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
    gameplay
  end

  def gameplay
    until @game_over == true
      puts "Choose a coordinate to place your shot."
      coordinate = gets.chomp
      @game.place_player_shot(coordinate)
      sleep 1.2
      @game.place_computer_shot
      sleep 1.2
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render(true)
      puts "==============PLAYER BOARD=============="
      puts @player_board.render(true)
    end
    @game.game_over_message
    start
    place_player_ships
    player_place_submarine
    player_place_cruiser
    gameplay
  end
end
