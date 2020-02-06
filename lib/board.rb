class Board
  def initialize
    @cell_names = ["A1","A2","A3","A4",
              "B1","B2","B3","B4",
              "C1","C2","C3","C4",
              "D1","D2","D3","D4"]
    @board_of_cells = Hash.new
    @cell_names.each do |name|
      @board_of_cells[name] = Cell.new(name)
    end
  end

  def cells
    @board_of_cells
  end

  def valid_coordinate?(coordinate)
    cells.keys.include?(coordinate)
  end

  def ship_valid_horizontal?(ship, coordinates)
    horiz = coordinates.map do |coordinate|
      coordinate.ord
      end
    horiz.uniq.length == 1 && ship.length == (coordinates.first..coordinates.last).to_a.length
  end

  def ship_valid_vertical?(ship, coordinates)
    vert = coordinates.map do |coordinate|
      coordinate[1]
      end
    vert.uniq.length == 1 && ship.length == (coordinates.first[0]..coordinates.last[0]).to_a.length
  end

  def valid_placement?(ship, coordinates)
    ship_valid_horizontal?(ship, coordinates) || ship_valid_vertical?(ship, coordinates)
  end

  def place(ship, coordinates)
    empty_ship_space = coordinates.map { |coordinate| cells[coordinate].empty? }
    if empty_ship_space.uniq.length == 1 && true
      coordinates.each do |coordinate|
        cells[coordinate].place_ship(ship)
      end
    else
      "Invalid placement, try again."
    end
  end

end
