require_relative '../lib/oystercard.rb'

describe Oystercard do
  it 'Check that a customer can put money on their card i.e. the topup method can be called' do
    expect(subject).to respond_to(:top_up)
  end

  it 'Checks that balance is increased by the topup amount' do
    subject.top_up(10)
    expect(subject.balance).to eq(10)
  end

  it 'Checks that you cannot topup more than 90' do
    max = Oystercard::MAX_BALANCE
    expect{subject.top_up(max + 1)}.to raise_error 'maximum balance 90 pounds'
  end

end
