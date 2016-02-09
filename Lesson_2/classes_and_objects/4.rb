# If we're trying to determine whether the two objects contain the same name
# how can we compare the two objects?

class Person
  attr_accessor :last_name, :first_name
  
  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end
    
  private

  def parse_full_name(full_name)
    array = full_name.split
    self.first_name = array.first
    self.last_name = array.count > 1 ? array.last : ""
  end
end

bob = Person.new("Robert Smith")
rob = Person.new("Robert Smith")

puts bob.name == rob.name #=> true
puts bob == rob #=> false

str1 = 'hello'
str2 = 'hello'
puts str1 == str2 #=> true

arr1 = [1]
arr2 = [1]
puts arr1 == arr2 #=> true

num1 = 1
num2 = 1
puts num1 == num2 #=> true

hash1 = {a: 1}
hash2 = {a: 1}
puts hash1 == hash2 #=> true
