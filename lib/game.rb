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
      # puts "==============PLAYER BOARD=============="
      # puts @player_board.render
      # player_place_ship1
    else
      puts  "Boo, you suck!"
    end
  end

  def place_computer_submarine

    # rand_coordinates = []
    # @computer_submarine.length.times do
    #   rand_coordinates << @computer_board.cells.keys.shuffle.first
    # end
    rand_coordinates = []
    until @computer_board.valid_placement?(@computer_submarine, rand_coordinates)
      rand_coordinates = []
      @computer_submarine.length.times do
        rand_coordinates << @computer_board.cells.keys.shuffle.first
      end
    end
    require "Pry"; binding.pry
  end

  def player_place_ship1
    puts "Your ships are: "
    puts "The #{@player_cruiser.name} which will take up #{@player_cruiser.length} spaces."
    puts "The #{@player_submarine.name} which will take up #{@player_submarine.length} spaces."
    puts "\nYou must place your ships on the board.  Spaces must be consecutive\nand obviously the ships have to be fully on the board."
    puts "Enter the coordinates of where you want to place the #{@player_submarine.name}:"
    print "> "
    ship1_coordinates = gets.chomp.delete(" ").split(",")
    until @player_board.valid_placement?(@player_submarine, ship1_coordinates) && ship1_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      puts "Enter new coordinates, the ones you entered are invalid."
      ship1_coordinates = gets.chomp.delete(" ").split(",")
    end
    puts "Finally, #{ship1_coordinates} are valid!"

    ship1_coordinates.each do |coord|
      @player_board.cells[coord].place_ship(@player_submarine)
    end
    puts "Your board now looks like this:"
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
      puts "Press n to move on to the next ship or u to replace the #{@player_submarine.name}."
      option_2 = gets.chomp
      if option_2 == "n"
        player_place_ship2
      elsif
        option_2 == "u"
        player_place_ship1
      end
  end

  def player_place_ship2
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)

    puts "Now place your #{@player_cruiser.name} which will take up #{@player_cruiser.length} spaces."
    print "> "
    ship2_coordinates = gets.chomp.delete(" ").split(",")
    until @player_board.valid_placement?(@player_cruiser, ship2_coordinates) && ship2_coordinates.each { |coord| @player_board.valid_coordinate?(coord) }
      puts "Enter new coordinates, the ones you entered are invalid."
      ship2_coordinates = gets.chomp.delete(" ").split(",")
    end
    puts "Finally, #{ship2_coordinates} are valid!"

    ship2_coordinates.each do |coord|
      @player_board.cells[coord].place_ship(@player_cruiser)
    end
    puts "Your board now looks like this:"
    puts "==============PLAYER BOARD=============="
    puts @player_board.render(true)
    puts "Press y to begin or u to replace the #{@player_cruiser.name}."
    option_3 = gets.chomp
    if option_3 == "y"
      turn
    elsif
      option_3 == "u"
      player_place_ship2
    end

  end
end
