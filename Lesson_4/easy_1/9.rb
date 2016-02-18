class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# what does self refer to in the cats_count method?

# in this case self is used to define a class method.
#  It will refer to The class Cat

kitty1 = Cat.new('tabby')
kitty2 = Cat.new('rag doll')

Cat.cats_count # => 2
