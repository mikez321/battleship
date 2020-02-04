require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_has_a_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_it_can_have_a_ship
    cell = Cell.new("B4")

    assert_nil = cell.ship
  end

  def test_it_can_be_empty
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_a_ship_can_be_placed_in_it
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
  end

  def test_if_it_has_a_ship_it_is_not_empty
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal false, cell.empty?

  end

end
