require './lib/game'
require './lib/board'
require './lib/cell'
require './lib/ship'

def start
  puts "Welcome to BATTLESHIP!"
  puts "Enter p to play. Enter q to quit"
  start_option = gets.chomp

  if start_option == "p"
    puts "Great! Lets play!"
    @game.place_computer_submarine
    @game.place_computer_cruiser
    @game.place_player_ships
  else
    puts  "Come back when you're ready for battle!"
  end
end
