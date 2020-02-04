require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def test_it_exists
    cruiser = Ship.new("Cruiser", 3)

    assert_instance_of Ship, cruiser
  end

  def test_it_has_attributes
    cruiser = Ship.new("Cruiser", 3)

    assert_equal "Cruiser", cruiser.name
    assert_equal 3, cruiser.length
  end

  def test_when_the_game_starts_it_is_healthy
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.health
  end

  def test_when_the_game_starts_it_is_not_sunk
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, cruiser.sunk?
  end

  def test_when_it_is_hit_its_health_decreases
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.health
    cruiser.hit
    assert_equal 2, cruiser.health
    cruiser.hit
    assert_equal 1, cruiser.health
  end

  def test_when_its_health_is_zero_it_is_sunk
    cruiser = Ship.new("Cruiser", 3)

    assert_equal 3, cruiser.health
    cruiser.hit
    cruiser.hit
    assert_equal 1, cruiser.health
    assert_equal false, cruiser.sunk?
    cruiser.hit
    assert_equal 0, cruiser.health
    assert_equal true, cruiser.sunk?
  end

end
