class Move
  VALUES = %w(r p s l sp).freeze

  attr_reader :value
  
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
  def initialize
    @value = 'rock'
  end

  def >(other_move)
    other_move.scissors? || other_move.lizard?
  end
end

class Paper < Move
    def initialize
    @value = 'paper'
  end

  def >(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Scissors < Move
  def initialize
    @value = 'scissors'
  end

  def >(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Lizard < Move
  def initialize
    @value = 'lizard'
  end

  def >(other_move)
    other_move.paper? || other_move.spock?
  end
end

class Spock < Move
  def initialize
    @value = 'spock'
  end

  def >(other_move)
    other_move.scissors? || other_move.rock?
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    @score = 0
    @move = nil
    set_name
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
  
  def convert_to_class(choice)
    case choice
    when 'r' then Rock.new
    when 'p' then Paper.new
    when 's' then Scissors.new
    when 'l' then Lizard.new
    when 'sp' then Spock.new
    end
  end
          
class Computer < Player
  def choose
    self.move = convert_to_class(Move::VALUES.sample)
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end
end

# game orchestration engine
class RPSGame
  WINNING_SCORE = 2

  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_opening_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock #{human.name}!"
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
    human.score += 1 if declare_winner == human.name
    computer.score += 1 if declare_winner == computer.name
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
    puts "#{declare_winner} has #{WINNING_SCORE} points and wins the game!"
  end

  def display_score
    puts "The score is #{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
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

  def play
    display_opening_message

    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      update_score
      display_score
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