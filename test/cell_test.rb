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
  end

  def test_if_it_has_a_ship_it_is_not_empty
    skip
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    assert_equal false, cell.empty?

  end

  def test_a_ship_can_be_fired_upon
    skip
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    assert_equal false, cell.fired_upon?
    cell.fire_upon
    assert_equal true, cell.fired_upon?
  end

  def test_if_it_has_a_ship_and_is_fired_upon_the_ship_is_damaged
    skip
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

  def test_it_has_an_option_to_show_ships
    skip
    cell_1 = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell_1.place_ship(cruiser)

    assert_equal cruiser, cell_1.ship
    assert_equal "S", cell_1.render(true)
  end

  def test_it_renders_output_for_fired_upon_and_hit_status
    skip
    cell_1 = Cell.new("B4")
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    assert_equal ".", cell_1.render

    cell_1.fire_upon
    assert_equal "M", cell_1.render

    cell_2.place_ship(cruiser)
    assert_equal ".", cell_2.render

    cell_2.fire_upon
    assert_equal "H", cell_2.render
  end

  def test_it_renders_an_x_if_a_ship_is_sunk
    skip
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)

    cell_2.place_ship(cruiser)
    assert_equal false, cruiser.sunk?

    cell_2.fire_upon
    2.times { cruiser.hit }

    assert_equal true, cruiser.sunk?
    assert_equal "X", cell_2.render
  end

end
