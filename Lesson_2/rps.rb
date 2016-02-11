#making a change

class Move
  VALUES = ['rock', 'paper', 'scissors'].freeze

  def initialize(value)
    @value = value
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

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
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
      puts "Please choose rock, paper, or scissors"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(choice)
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
  def choose
    self.move = Move.new(Move::VALUES.sample)
  end

  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end
end

# game orchestration engine
class RPSGame
  WINNING_SCORE = 10
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_opening_message
    puts "Welcome to Rock, Paper, Scissors, #{human.name}!"
    puts "First player to #{WINNING_SCORE} points wins."
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors!"
  end

  def display_moves
    puts "#{human.name} chooses #{human.move}."
    puts "#{computer.name} chooses #{computer.move}."
  end

  def declare_winner
    if human.move > computer.move
      :human
    elsif human.move < computer.move
      :computer
    end
  end

  def display_winner
    if declare_winner == :human
      puts "#{human.name} wins!"
    elsif declare_winner == :computer
      puts "#{computer.name} wins!"
    else
      puts "It's a tie"
    end
  end

  def update_score
    if declare_winner == :human
      human.score += 1
    elsif declare_winner == :computer
      computer.score += 1
    end
  end

  def display_score
    puts "The score is #{human.name}: #{human.score}, #{computer.name}: #{computer.score}"
  end

  def overall_winner?
    [human.score, computer.score].include?(WINNING_SCORE)
  end

  def display_overall_winner
    if human.score == WINNING_SCORE
      puts "#{human.name} has #{WINNING_SCORE} points and wins the game!"
    elsif computer.score == WINNING_SCORE
      puts "#{computer.name} has #{WINNING_SCORE} points and wins the game!"
    end
  end

  def reset_score
    human.score = 0
    computer.score = 0
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
