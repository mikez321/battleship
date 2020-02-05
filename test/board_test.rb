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
    assert_equal Hash, board.cells
    assert_equal 16, board.cells.length
  end

  def test_it_has_valid_coordiantes
    board = Board.new
    assert_equal true, board.valid_coordinate?("A1")
    assert board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    refute board.valid_coordinate?("E1")
  end

  def test_it_has_valid_placement
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    # first two are testing to make sure the valid_placement is accoring to ships
    refute board.valid_placement?(cruiser, ["A1", "A2"])
    refute board.valid_placement?(submarine, ["A2", "A3", "A4"])
    # next for are to make sure the coordiantes are consise
    refute board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute board.valid_placement?(submarine, ["A1", "C1"])
    refute board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute board.valid_placement?(submarine, ["C1", "B1"])
    # next two are to make sure they arent diagonal
    refute board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    refute board.valid_placement?(submarine, ["C2", "D3"])
    # just to double check all past test pass
    assert board.valid_placement?(submarine, ["A1", "A2"])
    assert board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end
end
