require './lib/ship'
require './lib/cell'
require './lib/board'
# require 'io/console'
require './lib/game_play'

class Game
  attr_reader :player_board, :player_cruiser, :player_submarine,
              :computer_board, :computer_cruiser, :computer_submarine, :game_over
  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Crusier", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Crusier", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @game_over = false
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
  end

  def place_player_shot(coordinate)
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

    if player_all_sunk || computer_all_sunk
      @game_over = true
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

    if player_all_sunk || computer_all_sunk
      @game_over = true
    end
  end

  def player_all_sunk
    @player_cruiser.sunk? && @player_submarine.sunk?
  end

  def computer_all_sunk
    @computer_cruiser.sunk? && @computer_submarine.sunk?
  end

end
