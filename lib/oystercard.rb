
class Oystercard
  CURRENT_BALANCE = 0
  MAX_BALANCE = 90

  attr_reader :balance
  attr_reader :max_balance
  attr_accessor :in_use

  def initialize(balance = CURRENT_BALANCE)
    @balance = balance
    @max = MAX_BALANCE
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  def touch_in
    @in_use = true
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_out
    @in_use = false
  end

  def top_up(amount)
    if (@balance + amount < MAX_BALANCE)
      @balance += amount
    else
      fail "maximum balance 90 pounds"
    end
  end
end
