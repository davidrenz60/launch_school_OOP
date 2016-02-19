class Greeting
  def greet(words)
    puts words
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

example = Hello.new
example.hi