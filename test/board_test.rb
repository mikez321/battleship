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

  def test_it_has_valid_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    # first two are testing to make sure the valid_placement is accoring to ships
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
    # # next four are to make sure the coordiantes are consecutive
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    assert_equal false, board.valid_placement?(submarine, ["A1", "C1"])
    assert_equal false, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    assert_equal false, board.valid_placement?(submarine, ["C1", "B1"])
    # next two are to make sure they arent diagonal
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
    # just to double check all past test pass
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_ship_can_be_placed
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert = nil, board.cells["A3"].ship
    board.place(cruiser, ["A1", "A2", "A3"])
    # assert_equal cruiser, board.cells["A3"].ship
    # assert_equal false, board.calls["C1"].ship
    # board.place(submarine, ["B1", "C1"])
    # assert_equal submarine, board.calls["C1"].ship
    # assert_equal submarine, board.cells["B1"].ship
    # board.place(cruiser, ["B1", "B2", "B3"])
    # assert_equal "Invalid placement, try again.", board.place(cruiser, ["B1", "B2", "B3"])

  end

  def test_board_can_render
    skip
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal "  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n", board.render
    board.place(cruiser, ["A1", "A2", "A3"])
    board.place(submarine, ["B1", "C1"])
    assert_equal "  1 2 3 4 \nA S S S . \nB S . . . \nC S . . . \nD . . . . \n"
  end
end
