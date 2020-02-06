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
end
