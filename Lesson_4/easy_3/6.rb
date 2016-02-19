# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     self.age += 1
#   end
# end

# self is used in the make_one_year_older method.
# make it so that you don't have to use it

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1   # in this case self and @ can be interchanged 
  end
end

bernie = Cat.new('tabby')
bernie.make_one_year_older
p bernie.age
