# add accessor method to view and change color
# add method to view but not modify the year

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def accelerate(num)
    @speed += num
    puts "The car accelerates #{num} mph"
  end

  def brake(num)
    @speed -= num
    puts "The car slows #{num} mph"
  end

  def shut_off
    @speed = 0
    puts "The car is stopped"
  end

  def current_speed
    puts "You are now going #{@speed} mph"
  end
end

nissan = MyCar.new(1980, "white", "Nissan Maxima")

nissan.color = "blue"
puts nissan.color
puts nissan.year
