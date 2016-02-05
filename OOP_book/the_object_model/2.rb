# a module is a set of methods that can be included in different classes
# they are accessible to a class by using the include keyword and module name

module Speak
  def speak(sound)
    puts "#{sound}"
  end
end

class Person
  include Speak
end

jim = Person.new

jim.speak("Hello")

 