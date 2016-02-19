class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0 # is an @ needed here?
  end
end

dave = BankAccount.new(1000)

dave.positive_balance

# the @ is not needed, since there is a getter method already defined by attr_reader
# the method balance will return @balance.