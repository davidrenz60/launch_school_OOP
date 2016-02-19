# class Game
#   def play
#     "Start the game!"
#   end
# end

# class Bingo
#   def rules_of_play
#     #rules of play
#   end
# end

# how can we get bingo to inherit the play method?

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

game1 = Bingo.new
puts game1.play