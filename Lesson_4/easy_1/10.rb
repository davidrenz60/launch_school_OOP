class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

# what needs to be called to create a new instance of Bag?

# a new instance needs to be created that takes 2 arguments
# there will be an error if initialized with the wrong number of arguments

plastic = Bag.new('blue', 'plastic')

paper = Bag.new # => ArgumentError



