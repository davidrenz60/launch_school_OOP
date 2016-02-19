class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

# what is the result of calling

oracle = Oracle.new
oracle.predict_the_future # => returns "You will " concatenated with one of the strings added from the array randomly
