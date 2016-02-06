class MyCar
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

nissan.accelerate(50)
nissan.current_speed
nissan.brake(25)
nissan.current_speed
nissan.shut_off
nissan.current_speed
