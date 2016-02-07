# how would you fix the error message?

# bob = Person.new
# bob.hi

# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>

# move the hi method so that it is not below the private reserved word

class Person
  def public_hi
    puts "Hi!"
  end

  private

  def private_hi
    puts "Hi!"
  end
end

dave = Person.new

dave.public_hi
dave.private_hi
