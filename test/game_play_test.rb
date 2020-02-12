require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require 'minitest/autorun'
require 'minitest/pride'

class GamePlayTest < Minitest::Test

  def test_it_exists
    gameplay = GamePlay.new

    assert_instance_of GamePlay, gameplay
  end

  def test_it_makes_things_to_play_the_game
    gameplay = GamePlay.new

    assert_instance_of Game, gameplay.game
    assert_instance_of Board, gameplay.player_board
    assert_instance_of Ship, gameplay.player_cruiser
    assert_instance_of Ship, gameplay.player_submarine
    assert_instance_of Board, gameplay.computer_board
    assert_instance_of Ship, gameplay.computer_cruiser
    assert_instance_of Ship, gameplay.computer_submarine
    assert_equal false, gameplay.game_over
  end

  def test_it_can_print_a_start_banner
    skip
    gameplay = GamePlay.new

    expected =
      " _______  _______  _______  _______  ___      _______  _______  __   __  ___   _______ ", gameplay.start_banner
  end

  def test_it_can_print_a_header
    skip
    gameplay = GamePlay.new

    expected = "=============* BATTLESHIP *============="

    assert_equal expected, gameplay.header
  end

end
