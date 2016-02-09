# Modify the class definition to facilitate the following methods. 
# Note that there is no name= setter method now.

# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'

class Person
  attr_accessor :last_name, :first_name
  
  def initialize(name)
    array = name.split
    @first_name = array.first
    @last_name = array.count > 1 ? array.last : ""
  end

  

  def name
    "#{first_name} #{last_name}".strip
  end
end



bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'