# what is @@cats_count and how does it work

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
    puts @@cats_count
  end

  def self.cats_count
    @@cats_count
  end
end

# this is an example of a class variable
# when an instance of Cat is created, the class variable is incremented by one
# we can access the variable by using the cats_count class method
# add puts @@cats_count in initialize method to test

kitty1 = Cat.new('tabby')
kitty1 = Cat.new('rag doll')
puts Cat.cats_count
