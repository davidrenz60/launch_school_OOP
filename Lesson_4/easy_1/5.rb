# which class has an instance variable?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

# Pizza class has a name instance variable, it is prefixed with '@'

#  can check by using instance_variables method

apple = Fruit.new('apple')
cheese = Pizza.new('cheese pizza')

p cheese.instance_variables # =>[:@name]
p apple.instance_variables # => []