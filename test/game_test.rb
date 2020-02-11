require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'minitest/autorun'
require 'minitest/pride'

class GameTest < Minitest::Test

  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_it_has_ships_and_boards
    game = Game.new

    assert_instance_of Board, game.player_board
    assert_instance_of Ship, game.player_cruiser
    assert_instance_of Ship, game.player_submarine
    assert_instance_of Board, game.computer_board
    assert_instance_of Ship, game.computer_cruiser
    assert_instance_of Ship, game.computer_submarine
  end

  def test_it_has_a_banner
    skip

  end

  def test_it_can_place_its_own_ships
    game = Game.new

    assert_equal false, game.computer_cruiser.placed?
    assert_equal false, game.computer_submarine.placed?

    game.place_computer_ships

    assert_equal true, game.computer_cruiser.placed?
    assert_equal true, game.computer_submarine.placed?
  end

  def test_it_can_display_a_header
  skip
  end

  def test_it_can_take_a_variety_of_inputs_for_coordinates
    game = Game.new

    assert_equal ["A1"], game.normalize_input_coordinates("a1")
    assert_equal ["A1", "B1"], game.normalize_input_coordinates("a1 b1")
    assert_equal ["A1", "B1"], game.normalize_input_coordinates("a1, b1")
    assert_equal ["A1", "B1"], game.normalize_input_coordinates("A1 b1")
    assert_equal ["A1", "B1"], game.normalize_input_coordinates("a1 B1")
    assert_equal ["A1", "B1"], game.normalize_input_coordinates("A1 B1")
    assert_equal ["A1", "B1"], game.normalize_input_coordinates("A1, B1")
  end

end
