
class Oystercard

  CURRENT_BALANCE = 0
  MAX_BALANCE = 90
  STATUS = "New oyster"

  attr_reader :balance
  attr_reader :max_balance
  attr_reader :status

  def initialize(balance=CURRENT_BALANCE)
    @balance = balance
    @max = MAX_BALANCE
  end


  def top_up(amount)
    if (@balance + amount < MAX_BALANCE)
       @balance += amount
    else
      fail 'maximum balance 90 pounds'
    end
  end


end
