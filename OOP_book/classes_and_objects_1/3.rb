# create a spray_paint method to change the color of the car

class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def spray_paint(color)
    self.color = color
    puts "Your car's new color is #{color}"
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

puts nissan.color
nissan.spray_paint("blue")
puts nissan.color
