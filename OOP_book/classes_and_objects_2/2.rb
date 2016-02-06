# Override the to_s method to create a user friendly print out of your object

class MyCar
  attr_accessor :year, :color, :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def to_s
    "This car is a #{self.year}, #{self.color}, #{self.model}."
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

nissan = MyCar.new(1980, "White", "Nissan Maxima")

puts nissan # puts will automatically call to_s
