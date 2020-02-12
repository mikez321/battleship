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

end
