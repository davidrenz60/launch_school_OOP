# why is there an error and how is this code fixed?

# class Person
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new("Steve")
# bob.name = "Bob"

# there is no setter method available,
# could change attr_reader to attr_accessor or attr_writer

class Person
  attr_accessor :name # could do attr_writer also if we don't want to be able to see data

  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

puts bob
