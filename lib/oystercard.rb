
class Oystercard
  INITIAL_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1

  attr_reader :balance, :max_balance, :entry_station
  attr_accessor :in_use

  def initialize(balance = INITIAL_BALANCE)
    @balance = balance
    @max = MAX_BALANCE
    @in_use = false
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
