# how can you access the volume instance variable?

class Cube
  def initialize(volume)
    @volume = volume
  end
end


# add getter access
class Cube
  attr_reader : volume
  
  def initialize(volume)
    @volume = volume
  end
    
end

#write getter method
class Cube
  def initialize(volume)
    @volume = volume
  end

  def volume
    @volume
  end
end


# note, can also access instance variables by using 'instance_variable_get'
# if no getter method was defined you could do  the following, but not reccommended

big_cube = Cube.new(500)
big_cube.instance_variable_get("@volume") # => 500
    