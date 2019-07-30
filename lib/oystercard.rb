
class Oystercard
  INITIAL_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance, :max_balance
  attr_accessor :in_use

  def initialize(balance = INITIAL_BALANCE)
    @balance = balance
    @max = MAX_BALANCE
    @in_use = false
  end

  def in_journey?
    @in_use
  end

  def touch_in
    fail "Insufficient balance" if @balance < MIN_BALANCE
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
