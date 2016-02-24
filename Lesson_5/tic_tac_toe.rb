class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def draw
    puts <<~MSG

          |     |
       #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}
          |     |
     -----+-----+-----
          |     |
       #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}
          |     |
     -----+-----+-----
          |     |
       #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}
          |     |
     MSG
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.select { |_, sq| sq.unmarked? }.keys
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def find_at_risk_square(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      marked_squares = squares.select { |value| value.marker == marker }
      if marked_squares.count == 2
        return @squares.select { |k, v| line.include?(k) && v.marker == Square::INITIAL_MARKER }.keys.first
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.count == 1
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  VALID_MARKERS = ['X', 'O']
  attr_reader :marker, :name
  attr_accessor :score

  def initialize
    @marker = nil
    @name = nil
    @score = 0
  end

  def set_name
    name = nil
    puts "Please enter your name:"
    loop do
      name = gets.chomp
      break unless name.empty?
      puts "Please enter a valid name."
    end
    @name = name
  end

  def choose_marker
    choice = nil
    puts "Choose your marker: #{VALID_MARKERS.join(' or ')}"
    loop do
      choice = gets.chomp.upcase
      break if VALID_MARKERS.include?(choice)

      puts "Please enter a valid marker."
    end
    @marker = choice
  end
end

class Computer < Player
  def set_name
    @name = ['Hal', 'R2D2', 'Sonny'].sample
  end

  def choose_marker(other_marker)
    valid_choices = VALID_MARKERS
    valid_choices -= [other_marker]
    @marker = valid_choices.sample
  end
end

class TTTGame
  WINNING_SCORE = 5

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Computer.new
    @current_marker = nil
  end

  def play
    game_setup
    loop do
      main_game
      if overall_winner?
        display_board_and_clear_screen
        display_overall_winner
        reset_score
      else
        display_result
      end
      break unless play_again?
      reset
    end
    display_goodbye_message
  end

  def clear
    system 'clear' or system 'cls'
  end

  private

  def game_setup
    clear
    display_opening_message
    human.set_name
    computer.set_name
    announce_players
    human.choose_marker
    computer.choose_marker(human.marker)
    choose_first_move
  end

  def main_game
    display_board_and_clear_screen
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      display_board_and_clear_screen
    end
    update_score
  end

  def overall_winner?
    [human.score, computer.score].include?(WINNING_SCORE)
  end

  def display_overall_winner
    puts ""
    case board.winning_marker
    when human.marker
      puts "***#{human.name} has #{WINNING_SCORE} points and wins the game!***"
    when computer.marker
      puts "***#{computer.name} has #{WINNING_SCORE} points and wins the game!***"
    end
  end

  def reset_score
    human.score = 0
    computer.score = 0
  end

  def update_score
    case board.winning_marker
    when human.marker
      human.score += 1
    when computer.marker
      computer.score += 1
    end
  end

  def display_score
    puts "The score is #{human.name}: #{human.score}. #{computer.name}: #{computer.score}"
  end

  def format_square_numbers(array, word='or', mark=', ')
    array[-1] = "#{word} #{array.last}" if array.length > 1
    array.join(mark)
  end

  def choose_first_move
    answer = nil
    loop do
      puts "Who will choose first? (1) #{human.name} (2) #{computer.name}"
      answer = gets.chomp.to_i
      break if [1, 2].include?(answer)
      puts "Please enter a vaild choice."
    end
    @current_marker = answer == 1 ? human.marker : computer.marker
  end

  def announce_players
    puts ""
    puts "Hello #{human.name}! You are playing against #{computer.name}."
  end

  def display_opening_message
    puts "Welcome to Tic-Tac-Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic-Tac-Toe! Goodbye!"
  end

  def display_board
    puts ""
    puts "#{human.name} is #{human.marker}. #{computer.name} is #{computer.marker}."
    board.draw
    puts ""
    display_score
  end

  def display_board_and_clear_screen
    clear
    display_board
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def human_moves
    puts "Choose a square: (#{format_square_numbers(board.unmarked_keys)})"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, invalid choice"
    end
    board[square] = human.marker
  end

  def computer_moves
    square = board.find_at_risk_square(human.marker)
    square = board.find_at_risk_square(computer.marker) unless square
    square = 5 if !square && board.unmarked_keys.include?(5)
    square = board.unmarked_keys.sample unless square
    board[square] = computer.marker
  end

  def display_result
    display_board_and_clear_screen

    case board.winning_marker
    when human.marker
      puts "#{human.name} wins!"
    when computer.marker
      puts "#{computer.name} wins!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break answer == 'y' if %w(y n).include?(answer)
      puts "Please enter y or n"
    end
  end

  def reset
    choose_first_move
    board.reset
    clear
  end
end

game = TTTGame.new
game.clear
game.play
