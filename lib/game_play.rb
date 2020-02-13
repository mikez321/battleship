require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'

class GamePlay
  attr_reader :game, :player_board, :player_cruiser, :player_submarine,
              :computer_board, :computer_cruiser, :computer_submarine, :game_over
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
    initialize
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
      @game.place_computer_ships
      place_player_ships_prompt
    elsif start_option == "q"
      system "clear"
      puts  "Come back when you're ready for battle!"
    end
  end

  def display_board(player)
    if (player == "computer")
      puts "=============COMPUTER BOARD============="
      puts @game.computer_board.render
    elsif (player == "player")
      puts "==============PLAYER BOARD=============="
      puts @game.player_board.render(true)
    end
  end

  def header
    puts "=============* BATTLESHIP *============="
    puts "\n\n"
  end

  def place_player_ships_prompt
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
    @game.place_player_ships_actions
    gameplay
  end

  def gameplay
    until @game.game_over == true
      system "clear"
      display_board("computer")
      print "\n\n"
      display_board("player")
      puts "Choose a coordinate to place your shot."
      coordinate = gets.chomp.upcase
      @game.place_player_shot(coordinate)
      sleep 1.2
      @game.place_computer_shot
      sleep 1.2
      system "clear"
      display_board("computer")
      print "\n\n"
      display_board("player")
    end
    game_over_message
  end

  def game_over_message
    system "clear"
    puts "+-+-+-+-+ +-+-+-+-+"
    puts "|G|a|m|e| |O|v|e|r|"
    puts "+-+-+-+-+ +-+-+-+-+"
    puts "\n\n"
    if @game.player_all_sunk?
      puts "HA, You lost! Try again!"
    else @game.computer_all_sunk?
      puts "I want a rematch!"
    end
    puts "\n\nPlay Again?  Y/N"
    start_option = gets.chomp.downcase
      until start_option == "y" || start_option == "n"
        puts "\n\n Play Again?  Y/N"
        start_option = gets.chomp.downcase
      end
      if start_option == "n"
        puts "Come back when you're ready for battle!"
      elsif start_option == "y"
        start
      end
  end
end
