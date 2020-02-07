require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
# require 'minitest/autorun'
# require 'minitest/pride'


game = Game.new
game.welcome
game.setup


# class GameTest < Minitest::Test
#
#
#   def test_it_exists
#     game = Game.new
#     assert_instance_of Game, game
#   end
#
#   def test_welcome
#     game = Game.new
#     assert_equal game.welcome
  # end

  # def test_game_can_start
  #   game = Game.new
  #   start_option = "p"
  #
  #   assert_equal "Heck yea!", game.game_start(start_option)
  #   start_option = "q"
  #   assert_equal "Bye Bye", game.game_start(start_option)
  #
  # end

  # def test_it_has_welcome
  #   game = Game.new
  #   expected =  "Welcome to BATTLESHIP"
  #               "Enter p to play. Enter q to quit."
  #   assert_equal expected, game.welcome()
  # end
  #
  # def test_when_game_starts_a_board_is_created
  #   board = Board.new
  #
  #   assert_instance_of Board, board
  # end
  #
  # def test_new_boad_has_no_ships_placed
  #   board = Board.new
  #
  #
  # end
# end
