class Move
  VALUES = %w(r p s l sp).freeze

  attr_accessor :value

  def initialize
    @value = self.class.to_s.downcase
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def to_s
    @value
  end
end

class Rock < Move
  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Scissors < Move
  def >(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Lizard < Move
  def >(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Spock < Move
  def >(other_move)
    other_move.scissors? || other_move.rock?
  end
end

class Player
  attr_accessor :move, :name, :score, :history

  def initialize
    @score = 0
    @move = nil
    @history = []
    set_name
  end

  def convert_to_class(letter)
    case letter
    when 'r' then Rock.new
    when 'p' then Paper.new
    when 's' then Scissors.new
    when 'l' then Lizard.new
    when 'sp' then Spock.new
    end
  end
end

class Human < Player
  def choose
    choice = nil
    loop do
      puts "Please choose (r)ock, (p)aper, (s)cissors, (l)izard, or (sp)ock"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice"
    end

    self.move = convert_to_class(choice)
  end

  def set_name
    n = nil
    loop do
      puts "Enter your name"
      n = gets.chomp
      break unless n.empty?
      puts "Please enter a valid name"
    end
    self.name = n
  end
end

class Computer < Player
  def set_name
    self.name = self.class.to_s
  end
end

# Number5 will check if player picks same 3x in a row. Picks winner against that move
class Number5 < Computer
  def choose(history)
    self.move = case find_repeat_move(history)
                when 'rock' then Spock.new
                when 'paper' then Lizard.new
                when 'scissors' then Rock.new
                when 'lizard' then Scissors.new
                when 'spock' then Paper.new
                else convert_to_class(Move::VALUES.sample)
                end
  end

  def find_repeat_move(history)
    recent_moves = history.map { |move| move[0] }.last(3)
    history.count > 2 && recent_moves.uniq.count == 1 ? recent_moves.last : nil
  end
end

# Sonny will adjust choices based on losing with rock more than 60% of time
class Sonny < Computer
  def sonny_choice
    case rand(100)
    when (0..3) then 'r'
    when (4..27) then 'p'
    when (28..51) then 's'
    when (52..75) then 'l'
    when (76..99) then 'sp'
    end
  end

  def choose
    self.move = if rock_losses?
                  convert_to_class(sonny_choice)
                else
                  convert_to_class(Move::VALUES.sample)
                end
  end

  def rock_losses?
    moves = history.map { |move| move[0] }.count('rock')
    losses = history.count(['rock', 'loss'])
    loss_percentage = losses.to_f / moves.to_f

    moves > 4 && loss_percentage > 0.6
  end
end

# R2D2 only chooses rock
class R2D2 < Computer
  def choose
    self.move = Rock.new
  end
end

# Hal has custom choice percentages, never chooses paper.
class Hal < Computer
  def choose
    self.move = case rand(100)
                when (0..49) then Scissors.new
                when (50..59) then Rock.new
                when (60..79) then Lizard.new
                when (80..99) then Spock.new
                end
  end
end

# Chappie has default random choice
class Chappie < Computer
  def choose
    self.move = convert_to_class(Move::VALUES.sample)
  end
end

# game orchestration engine
class RPSGame
  WINNING_SCORE = 10
  attr_accessor :human, :computer

  def initialize
    display_opening_message
    @human = Human.new
    @computer = convert_to_class(choose_opponent)
  end

  def choose_opponent
    number = nil
    loop do
      puts "Choose your opponent:"
      puts "(1) R2D2, (2) Hal, (3) Number5, (4) Sonny, (5) Chappie"
      number = gets.chomp.to_i
      break if [1, 2, 3, 4, 5].include?(number)
      puts "Please choose a valid number"
    end
    number
  end

  def convert_to_class(number)
    case number
    when 1 then R2D2.new
    when 2 then Hal.new
    when 3 then Number5.new
    when 4 then Sonny.new
    when 5 then Chappie.new
    end
  end

  def choose_moves(history)
    human.choose
    computer.class == Number5 ? computer.choose(history) : computer.choose
  end

  def display_opening_message
    system 'clear' or system 'cls'
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    puts "First player to #{WINNING_SCORE} points wins."
  end

  def display_goodbye_message
    puts "Thanks for playing. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chooses #{human.move}."
    puts "#{computer.name} chooses #{computer.move}."
  end

  def declare_winner
    if human.move > computer.move
      human.name
    elsif computer.move > human.move
      computer.name
    end
  end

  def update_score
    ObjectSpace.each_object(Player) {|player| player.score += 1 if player.name == declare_winner }
  end

  def overall_winner?
    [human.score, computer.score].include?(WINNING_SCORE)
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def display_winner
    puts declare_winner ? "#{declare_winner} wins!" : "It's a tie."
  end

  def display_overall_winner
    puts "***#{declare_winner} has #{WINNING_SCORE} points and wins the game!***"
  end

  def display_score
    puts "The score is #{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
  end

  def update_history
    case declare_winner
    when human.name
      human.history << [human.move.value, 'win']
      computer.history << [computer.move.value, 'loss']
    when computer.name
      human.history << [human.move.value, 'loss']
      computer.history << [computer.move.value, 'win']
    else
      human.history << [human.move.value, 'tie']
      computer.history << [computer.move.value, 'tie']
    end
  end

  def display_history
    human_moves = human.history.last(3).reverse
    computer_moves = computer.history.last(3).reverse
    puts "#{human.name}'s recent moves: #{human_moves}"
    puts "#{computer.name}'s recent moves: #{computer_moves}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, please enter y or n"
    end

    answer == 'y'
  end

  def main_game
    display_history
    choose_moves(human.history)
    display_moves
    display_winner
    update_score
    display_score
    update_history
  end

  def play
    loop do
      main_game
      if overall_winner?
        display_overall_winner
        reset_score
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
