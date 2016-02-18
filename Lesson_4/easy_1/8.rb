class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

# what does self refer to?

# self refers to the instance of the cat class that will call the make_one_year_older method

kitty = Cat.new('tabby')
kitty.make_one_year_older # => here self is referring to 'kitty' (instance of Cat)
p kitty.age # => 1