require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'mocha/minitest'
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

  def test_it_can_place_its_own_ships
    game = Game.new

    assert_equal false, game.computer_cruiser.placed?
    assert_equal false, game.computer_submarine.placed?

    game.place_computer_ships

    assert_equal true, game.computer_cruiser.placed?
    assert_equal true, game.computer_submarine.placed?
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

  def test_if_coordinates_are_valid_a_player_can_place_ships
    game = Game.new

    assert_equal false, game.player_submarine.placed?

    game.ship_placer(game.player_submarine, ["A1", "A2"])

    assert_equal true, game.player_submarine.placed?
  end

  def test_game_is_over_when_all_ships_are_sunk
    skip
    game = Game.new

    assert_equal false, game.player_all_sunk?
    game.stubs(:player_all_sunk?).returns(true)
    assert_equal true, game_over?

    assert_equal false, game.computer_all_sunk?
    # game.stubs(:computer_all_sunk).returns(true)
    # assert_equal true, game_over
  end

end
