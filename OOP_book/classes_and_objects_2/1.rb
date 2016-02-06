# write a method that will calculate gas mileage for any car

class MyCar
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def self.gas_mileage(miles, gallons)
    "the gas mileage is #{miles / gallons} miles per gallon"
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

puts MyCar.gas_mileage(190, 8)
