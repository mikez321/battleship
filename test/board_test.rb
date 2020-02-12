require './lib/board'
require './lib/cell'
require './lib/ship'
require 'minitest/autorun'
require 'minitest/pride'

class BoardTest < Minitest::Test

  def test_it_exists
    board = Board.new
    assert_instance_of Board, board
  end

  def test_it_has_cells
    board = Board.new
    assert_instance_of Hash, board.cells
    assert_equal 16, board.cells.length
  end

  def test_it_has_valid_coordiantes
    board = Board.new
    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
  end

  def test_valid_coordinates_can_not_have_repeated_cells
    board = Board.new

    assert_equal true, board.all_coordinates_are_unique?(["A1", "A2", "A3"])
    assert_equal false, board.all_coordinates_are_unique?(["A1", "A3", "A3"])
  end

  def test_it_has_valid_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)


    # first two are testing to make sure the valid_placement is accoring to ships
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(cruiser, ["F1", "F2", "F3"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    # # # # next four are to make sure the coordiantes are consecutive
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A4", "A3"])
    assert_equal false, board.valid_placement?(cruiser, ["A1", "D1", "C1"])
    # # next two are to make sure they arent diagonal
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    # # just to double check all past test pass
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal false, board.valid_placement?(cruiser, ["H1", "H2", "H3"])
  end

  def test_ship_can_be_placed
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert = nil, board.cells["A3"].ship
    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal cruiser, board.cells["A3"].ship
    assert_equal true, cruiser.placed?
    assert = nil, board.cells["C1"].ship
    board.place(submarine, ["B1", "C1"])
    assert_equal true, submarine.placed?
    assert_equal submarine, board.cells["C1"].ship
    assert_equal submarine, board.cells["B1"].ship
  end

  def test_placement_is_only_valid_if_space_is_empty
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.place(submarine, ["B1", "C1"])
    assert_equal submarine, board.cells["C1"].ship
    assert_equal submarine, board.cells["B1"].ship

    assert_equal false, board.ship_space_valid?(["C1", "C2", "C3"])
    assert_equal true, board.ship_space_valid?(["A1", "A2", "A3"])
  end

  def test_board_can_render
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    board.place(cruiser, ["A1", "A2", "A3"])
    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    assert_equal "  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n", board.render(true)
  end
end
