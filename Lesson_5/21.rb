class Participant
  attr_accessor :hand, :name

  def initialize
    @hand = []
    set_name
  end

  def busted?
    total > 21
  end

  def hit!(card)
    hand << card
  end

  def total
    sum = 0
    hand.each do |card|
      sum += card.face_value
    end

    number_of_aces.times do
      sum -= 10 if sum > 21
    end

    sum
  end

  def display_cards
    hand.each do |card|
      puts card
    end
    puts "Total of: #{total}"
  end

  private

  def number_of_aces
    hand.count { |card| card.face == "A" }
  end
end

class Player < Participant

  def set_name
    puts "Please enter your name:"
    answer = nil
    loop do
      answer = gets.chomp
      break  unless answer.empty?
      puts "Please enter a valid name."
    end
    self.name = answer
  end
end

class Dealer < Participant
  COMPUTER_NAMES = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5']

  def set_name
    self.name = COMPUTER_NAMES.sample
  end

  def display_one_card
    puts hand[0].to_s
    puts "[---]"
    puts "Total of: #{hand[0].face_value}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end
    @cards.shuffle!
  end

  def deal_card!
    cards.pop
  end
end

class Card
  SUITS = ["\u2660".encode('utf-8'), "\u2663".encode('utf-8'), "\u2666".encode('utf-8'), "\u2665".encode('utf-8')]
  FACES = %w(A K Q J) + (2..10).to_a

  attr_reader :suit, :face

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def to_s
    "[#{face} #{suit}]"
  end

  def face_value
    if face == "A"
      11
    elsif face.to_i == 0
      10
    else
      face
    end
  end
end

class TwentyOne
  attr_accessor :deck, :player, :dealer
  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    display_welcome_message

    loop do
      deal_initial_hands!
      display_hands_in_progress
      player_turn!
      dealer_turn! if !player.busted?
      display_final_hands
      someone_busted? ? display_busted : display_result

      break unless play_again?
      reset
    end

    display_goodbye_message
  end

  def clear
    system 'clear' or system 'cls'
  end

  def display_welcome_message
    clear
    puts "Welcome to 21, #{player.name}!"
    puts ""
    puts "#{dealer.name} will be your dealer."
  end

  def display_goodbye_message
    puts "Thanks for playing 21. Goodbye!"
  end

  def deal_initial_hands!
    2.times do
      player.hand << deck.deal_card!
      dealer.hand << deck.deal_card!
    end
  end

  def display_hands_in_progress
    puts "--------------------------"
    puts "#{player.name}'s cards:"
    player.display_cards
    puts "--------------------------"
    puts "#{dealer.name}'s' cards:"
    dealer.display_one_card
    puts "--------------------------"
    puts ""
  end

  def display_final_hands
    puts "**************************"
    puts "#{player.name}'s cards:"
    player.display_cards
    puts "**************************"
    puts "#{dealer.name}'s' cards:"
    dealer.display_cards
    puts "**************************"
    puts ""
  end

  def hit_or_stay
    answer = nil
    puts "Would you like to (h)it or (s)tay?"
    loop do
      answer = gets.chomp.downcase
      break answer if ['h', 's'].include?(answer)
      puts "Please enter (h) or (s)."
    end
  end

  def player_turn!
    loop do
      choice = hit_or_stay
      if choice == 'h'
        player.hit!(deck.deal_card!)
        clear
        display_hands_in_progress
        break if player.busted?
      else
        puts "You choose to stay with #{player.total}"
        puts ""
        break
      end
    end
  end

  def dealer_turn!
    puts "Dealer shows:"
    dealer.display_cards
    loop do
      sleep 1
      break if dealer.busted?
      if dealer.total < 17
        dealer.hit!(deck.deal_card!)
        puts "Dealer hits...=> #{dealer.hand.last}"
      else
        puts "Dealer stays at #{dealer.total}"
        puts ""
        break
      end
    end
  end

  def display_result
    if player.total > dealer.total
      puts "#{player.name} wins!"
    elsif player.total < dealer.total
      puts "#{dealer.name} wins!"
    else
      puts "Push"
    end
  end

  def someone_busted?
    player.busted? || dealer.busted?
  end

  def display_busted
    if player.busted?
      puts "#{player.name} busts, #{dealer.name} wins!"
    else
      puts "#{dealer.name} busts, #{player.name} wins!"
    end
  end

  def play_again?
    puts ""
    puts "Would you like to play again? (y/n)"
    answer = nil
    loop do
      answer = gets.chomp.downcase
      break answer == 'y' if ['y', 'n'].include?(answer)
      puts "Please enter (y) or (n)"
    end
  end

  def reset
    @deck = Deck.new
    player.hand = []
    dealer.hand = []
    clear
  end
end

TwentyOne.new.start
