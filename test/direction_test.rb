require './lib/direction'
require './lib/cell'
# require './lib/board'
require './lib/ship'
require 'minitest/autorun'
require 'minitest/pride'

class DirectionTest < Minitest::Test

  def test_it_exists
    direction = Direction.new(3, ["A1", "A2", "A3"])
    assert_instance_of Direction, direction
  end

  def test_coord_lengths_match_ship_length
    direction = Direction.new(3, ["A1", "A2", "A3"])
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, direction.length_match?
  end

  def test_coordiantes_are_consistent
    direction = Direction.new(3, ["A1", "A2", "A3"])
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, direction.none_missed?

    direction = Direction.new(3, ["A1", "B2"])
    submarine = Ship.new("Submarine", 2)
    assert_equal false, direction.none_missed?
  end

  def test_case_name
    direction = Direction.new(3, ["A1", "A2", "A3"])
    cruiser = Ship.new("Cruiser", 3)
    assert_equal true, direction.horizontal?
  end
end
