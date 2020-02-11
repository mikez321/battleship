class Cell
  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @empty = true
    @fired_upon = false
  end

  def empty?
    @empty
  end

  def place_ship(ship)
    @ship = ship
    @empty = false
    ship.placed = true
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    @fired_upon = true
    if @ship != nil
      @ship.hit
    end
  end

  def render(ship = false)
    if fired_upon? && empty?
      "M"
    elsif ship && !fired_upon? && !empty?
      "S"
    elsif fired_upon? && !empty? && !@ship.sunk?
      "H"
    elsif fired_upon? && !empty? && @ship.sunk?
      "X"
    else empty?
      "."
    end
  end
end
