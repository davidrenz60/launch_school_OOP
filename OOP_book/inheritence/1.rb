# create a Vehicle superclass

class Vehicle
  attr_accessor :year, :color, :model

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
    puts "You accelerate #{num} mph"
  end

  def brake(num)
    @speed -= num
    puts "You slow #{num} mph"
  end

  def shut_off
    @speed = 0
    puts "You stopped"
  end

  def current_speed
    puts "You are now going #{@speed} mph"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "This car is a #{self.year}, #{self.color}, #{self.model}."
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2

  def to_s
    "This truck is a #{self.year}, #{self.color}, #{self.model}."
  end
end

car = MyCar.new(1980, "white", "Nissan Maxima")
truck = MyTruck.new(2010, "black", "Chevy Silverado")

puts car
puts truck
