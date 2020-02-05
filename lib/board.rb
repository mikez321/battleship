class Board
  def initialize
    @cells = ["A1","A2","A3","A4",
              "B1","B2","B3","B4",
              "C1","C2","C3","C4",
              "D1","D2","D3","D4"]
  end

  def cells
    board_of_cells = Hash.new
    @cells.each do |cell_name|
      board_of_cells[cell_name] = Cell.new(cell_name)
    end
    board_of_cells
  end
end
