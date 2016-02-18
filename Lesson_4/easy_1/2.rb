# need to include the Speed module in each class
# both truck and car now have access to the go_fast method

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed

  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed

  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

nissan = Car.new
nissan.go_fast
toyota = Truck.new
toyota.go_fast