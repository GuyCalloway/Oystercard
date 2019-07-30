require_relative "../lib/oystercard.rb"


describe Oystercard do

  let(:station) { double :station }
  let(:station2) { double :station2 }

  let(:journey) { { entry_station: station, exit_station: station2 } }

  it "Check that a customer can put money on their card i.e. the topup method can be called" do
    expect(subject).to respond_to(:top_up)
  end

  it "Checks that balance is increased by the topup amount" do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end

  it "Checks that max balance is enforced" do
    expect { subject.top_up(100) }.to raise_error "Maximum balance of #{Oystercard::MAX_BALANCE} exceeded"
  end

  it "checks that cards state is not in_journey" do
    expect(subject).to_not be_in_journey
  end

  it "can touch in using minimum top up" do
    minimum_balance = Oystercard::MIN_BALANCE
    subject.top_up(minimum_balance)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end

  it "checks touch out changes in journey to false" do
    subject.top_up(5)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject).to_not be_in_journey
  end

  it "raises error if card has less than minimum balance" do
    expect { subject.touch_in(station) }.to raise_error "Insufficient balance"
  end

  it "deducts minimum_charge on touch-out" do
    expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MIN_CHARGE)
  end

  it "stores the entry station" do
    subject.top_up(Oystercard::MIN_CHARGE)
    subject.touch_in(station)
    expect(subject.entry_station).to eq (station)
  end

  it "stores entry and exit location in hash" do
    subject.top_up(Oystercard::MIN_CHARGE)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.journey).to eq({:entry_station => station, :exit_station => station2})
  end

  it "stores a journey" do
    subject.top_up(Oystercard::MIN_CHARGE)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.journeys).to include journey
  end
  # it 'Checks that the card can be used to Touch_in' do
  #   subject.top_up(10)
  #   subject.touch_in
  #   expect(subject.status).to eq("In Journey")
  # end
  #
  # it 'Checks that the card can be used to Touch_out' do
  #   subject.top_up(10)
  #   subject.touch_out
  #   expect(subject.status).to eq("Not In Journey")
  # end
  #
  # it 'Checks that the card cannot be used to touch in unless the minimum £1 balance has been met' do
  #   expect{subject.touch_in}.to raise_error
  # end
  #
  # it 'Checks that the balance has the minimum fare deducted after a touch_out' do
  #   expect{subject.touch_out}.to change{subject.balance}.by(-1)
  # end

end
