# class Cat
#   def initialize(type)
#     @type = type
#   end
# end

# make a custom to_s instance method

class Cat
  attr_reader :type
  
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

garfield = Cat.new('tabby')
puts garfield

# might be better to call this method display_type, rather than override to_s

