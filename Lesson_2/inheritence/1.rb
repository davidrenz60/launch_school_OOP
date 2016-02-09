class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim"
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim

bernie = Bulldog.new
puts bernie.swim
puts bernie.speak
