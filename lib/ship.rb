class Ship
  attr_reader :name, :length, :health
  attr_accessor :placed
  def initialize(name, length)
    @name = name
    @length = length
    @health = @length
    @sunk = false
    @placed = false
  end

  def sunk?
    @sunk
  end

  def hit
    @health -= 1
    if @health == 0
      @sunk = true
    end
  end

  def placed?
    @placed
  end
end
