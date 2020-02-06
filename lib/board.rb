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

  def ship_horizontal?(coordinates)
    horiz = coordinates.map do |coordinate|
      coordinate.ord
      end
    horiz.uniq.length == 1
  end

  def ship_vertical?(coordinates)
    vert = coordinates.map do |coordinate|
    coordinate[1]
    end
    vert.uniq.length == 1
  end

  def ship_covers_coordinates(ship, coordinates)
    coordinates.length == ship.length &&
    (coordinates[0]..coordinates[-1]).to_a.length == ship.length
  end

  def valid_placement?(ship, coordinates)
    ship_vertical?(coordinates) || ship_horizontal?(coordinates) &&
    ship_covers_coordinates(ship,coordinates)
  end


end
