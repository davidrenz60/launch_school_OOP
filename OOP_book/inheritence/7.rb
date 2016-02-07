# create a better grade than method

class Student
  attr_accessor :name

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(name) # you can access other objects protected method
    self.grade > name.grade
  end

  protected # this will allow to call "something.grade" method for other objects, private would not allow

  def grade
    @grade
  end
end

dave = Student.new("Dave", 90)
joe = Student.new("Joe", 75)

p dave.better_grade_than?(joe)
