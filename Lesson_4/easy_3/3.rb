class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

# create 2 different instances of class with seperate states

bernie = AngryCat.new('Bernie', 5)
sparky = AngryCat.new('Sparky', 10)

bernie.name
bernie.age

sparky.name
sparky.age