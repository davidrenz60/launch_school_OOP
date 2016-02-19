# Ruby will use a method lookup pattern, can call ancestors to view lookup path

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

p Orange.ancestors # => [Orange, Taste, Object, Kernel, BasicObject]

tapatio = HotSauce.new
p HotSauce.ancestors # => [HotSauce, Taste, Object, Kernel, BasicObject]

p tapatio.ancestors # => undefined method. ancestors is a class method, can't be called on instances