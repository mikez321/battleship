require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game_play'

class Game

  def initialize
    @player_board = Board.new
    @player_cruiser = Ship.new("Crusier", 3)
    @player_submarine = Ship.new("Submarine", 2)
    @computer_board = Board.new
    @computer_cruiser = Ship.new("Crusier", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @game_over = false
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
  end
end
