
class Oystercard
  INITIAL_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_CHARGE = 1

  attr_reader :balance, :max_balance, :entry_station, :journey
  attr_accessor :in_use

  def initialize(balance = INITIAL_BALANCE)
    @balance = balance
    @max = MAX_BALANCE
    @in_use = false
    @journey = {}
    @journeys = []
  end

  def touch_in(station)
    fail "Insufficient balance" if @balance < MIN_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @exit_station = station
    log
    @entry_station = nil
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} exceeded" if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    @entry_station
  end

  def log
    @journey = {:entry_station => @entry_station, :exit_station => @exit_station}
  end

  def journeys
    @journeys << journey
  end


  private

  def deduct(amount)
    @balance -= amount
  end
end
