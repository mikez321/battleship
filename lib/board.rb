class Board
  def initialize
    @cell_names = ["A1","A2","A3","A4",
              "B1","B2","B3","B4",
              "C1","C2","C3","C4",
              "D1","D2","D3","D4"]
    @board_of_cells = Hash.new
  end

  def cells
    @cell_names.each do |name|
      @board_of_cells[name] = Cell.new(name)
    end
    @board_of_cells
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end
end
