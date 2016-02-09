class Person
  attr_accessor :last_name, :first_name
  
  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  def to_s
    name
  end
    
  private

  def parse_full_name(full_name)
    array = full_name.split
    self.first_name = array.first
    self.last_name = array.count > 1 ? array.last : ""
  end
end


# w/o to_s instance method
# bob = Person.new("Robert Smith")
# puts "The person's name is #{bob}" #=> #<Person:0x007fe10207f900>

# with the new to_s instance method
bob = Person.new("Robert Smith")
puts "The person's name is #{bob}" 



