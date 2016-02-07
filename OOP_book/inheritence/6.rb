# create a method age that calls a private method

module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  attr_accessor :year, :color, :model

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    "There are #{@@number_of_vehicles} vehicles"
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

  def spray_paint(color)
    self.color = color
    puts "The color is now #{color}"
  end

  def age
    "This vehicle is #{years_old} years old"
  end
  
  private

  def years_old
    Time.now.year - self.year
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "This car is a #{self.year}, #{self.color}, #{self.model}."
  end
end

class MyTruck < Vehicle
  include Towable

  NUMBER_OF_DOORS = 2

  def to_s
    "This truck is a #{self.year}, #{self.color}, #{self.model}."
  end
end

car = MyCar.new(1980, "white", "Nissan Maxima")
truck = MyTruck.new(2010, "black", "Chevy Silverado")

p car.age
p truck.age
