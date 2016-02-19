# what is the difference between these two?

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# both will work the same, but self is not necessary in the second example
# as a convention, it is advisable to avoid self when not necessary

