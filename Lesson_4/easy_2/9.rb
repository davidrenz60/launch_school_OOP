# class Game
#   def play
#     "Start the game!"
#   end
# end

# class Bingo < Game
#   def rules_of_play
#     #rules of play
#   end
# end

# what if play method is added to Bingo class?

# when play is called, Ruby will use the method as soon as it is found.
# It first looks in the class of the instance that called, so Bingo's play method is used

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def play
    "Starting Bingo!"
  end

  def rules_of_play
    #rules of play
  end
end

game1 = Bingo.new
game1.play  # => "Starting Bingo!"