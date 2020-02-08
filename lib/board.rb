class Board
  def initialize
    @cells= {
      "A1" => Cell.new("A1"),
      "A2" => Cell.new("A2"),
      "A3" => Cell.new("A3"),
      "A4" => Cell.new("A4"),
      "B1" => Cell.new("B1"),
      "B2" => Cell.new("B2"),
      "B3" => Cell.new("B3"),
      "B4" => Cell.new("B4"),
      "C1" => Cell.new("C1"),
      "C2" => Cell.new("C2"),
      "C3" => Cell.new("C3"),
      "C4" => Cell.new("C4"),
      "D1" => Cell.new("D1"),
      "D2" => Cell.new("D2"),
      "D3" => Cell.new("D3"),
      "D4" => Cell.new("D4")
    }
  end

  def cells
    @cells
  end

  def valid_coordinate?(coordinates)
    cells.keys.include?(coordinates)
  end

  def ascending_only?(coordinates)
    coordinates == coordinates.sort
  end

  def ship_valid_horizontal?(ship, coordinates)
    horiz = coordinates.map do |coordinate|
      coordinate.ord
    end
    horiz.uniq.length == 1 &&
      coordinates.length == (coordinates.sort.first..coordinates.sort.last).to_a.length &&
      ship.length == coordinates.length &&
      ascending_only?(coordinates)
  end

  def ship_valid_vertical?(ship, coordinates)
    vert = coordinates.map do |coordinate|
      coordinate[1]
      end
    vert.uniq.length == 1 &&
      coordinates.length == (coordinates.sort.first[0]..coordinates.sort.last[0]).to_a.length &&
      ship.length == coordinates.length &&
      ascending_only?(coordinates)
  end

  def ship_space_valid?(ship, coordinates)
    ship_space = coordinates.map { |coordinate| cells[coordinate].empty? }
    ship_space.uniq.length == 1
  end

  def all_coordinates_are_unique?(coordinates)
    coordinates.length == coordinates.uniq.length
  end

  def valid_placement?(ship, coordinates)
    (ship_valid_horizontal?(ship, coordinates) ||
      ship_valid_vertical?(ship, coordinates)) &&
      ship_space_valid?(ship, coordinates) &&
      all_coordinates_are_unique?(coordinates)
  end

  def place(ship, coordinates)
    if valid_placement?(ship, coordinates)
      coordinates.each do |coordinate|
        cells[coordinate].place_ship(ship)
      end
    end
  end

  def render(ship = false)
"  1 2 3 4 \n" +
"A #{["A1", "A2", "A3", "A4"].map {|coord| @cells[coord].render(ship)}.join(" ")} \n" +
"B #{["B1", "B2", "B3", "B4"].map {|coord| @cells[coord].render(ship)}.join(" ")} \n" +
"C #{["C1", "C2", "C3", "C4"].map {|coord| @cells[coord].render(ship)}.join(" ")} \n" +
"D #{["D1", "D2", "D3", "D4"].map {|coord| @cells[coord].render(ship)}.join(" ")} \n"
  end
end
