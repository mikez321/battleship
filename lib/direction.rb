class Direction
  attr_reader :length, :coordinates
  def initialize(length, coordinates)
  @length = length
  @coordinates = coordinates
  end

  def length_match?
    coordinates.length == length
  end

  def none_missed?
    length == (coordinates[0]..coordinates[-1]).to_a.length
  end

  def horizontal?
  horiz = coordinates.map do |coordinate|
    coordinate.ord
    end
  horiz.uniq.length == 1
  end

  def vertical?
  vert = coordinates.map do |coordinate|
  coordinate[1]
  end
  vert.uniq.length == 1
  end

  def diagonal?
    !vertical? && !horizontal?
  end

end

boat = Direction.new(3, ["A1", "B2", "C3"])

boat.length_match?
boat.none_missed?
boat.horizontal?
boat.vertical?
boat.diagonal?
