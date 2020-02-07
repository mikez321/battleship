class Game
  def welcome
    "Welcome to Battleship!\nPress q to quit or p to start"
    start_option = gets.chomp
  end

  def begin_or_end(start_option)
    if start_option == "p"
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)
    else
      "Bye!"
    end
end
