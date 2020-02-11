require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_starts_with_a_coordinate_and_empty
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
    assert_nil = cell.ship
    assert_equal true, cell.empty?
  end

  def test_a_ship_can_be_placed_in_it
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
    assert_equal true, cruiser.placed? 
  end

  def test_if_it_has_a_ship_it_is_not_empty
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal false, cell.empty?
  end

  def test_a_ship_can_be_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, cell.fired_upon?
    cell.fire_upon
    assert_equal true, cell.fired_upon?
  end

  def test_if_it_has_a_ship_and_is_fired_upon_the_ship_is_damaged
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?

    cell.fired_upon?
    assert_equal false, cell.fired_upon?
    assert_equal 3, cell.ship.health

    cell.fire_upon
    assert_equal 2, cell.ship.health

    cell.fired_upon?
    assert_equal true, cell.fired_upon?
  end

  def test_it_can_render_every_option
    cell_1 = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell_2 = Cell.new("C3")

    assert_equal ".", cell_1.render
    cell_1.fire_upon
    assert_equal "M", cell_1.render
    cell_2.place_ship(cruiser)
    assert_equal "S", cell_2.render(true)
    cell_2.fire_upon
    assert_equal "H", cell_2.render(true)
    cell_2.fire_upon
    refute cruiser.sunk?
    cell_2.fire_upon
    assert_equal "X", cell_2.render(true)
  end
end
