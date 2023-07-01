require 'spec_helper'
require 'bowling_scorer/roll'
require 'bowling_scorer/game_type'
require 'bowling_scorer/ten_pin/ten_pin_roll'
require 'bowling_scorer/factory/roll_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_roll_factory'

RSpec.describe TenPinRollFactory do
  describe '#create_rolls' do
    let(:all_strikes) { ['10'] * 12 }

    it 'creates valid TenPinRoll' do
      expect(described_class.new.create_rolls(all_strikes).first).to be_a(TenPinRoll)
    end

    it 'creates the correct number of rolls' do
      expect(described_class.new.create_rolls(all_strikes).size).to eq(all_strikes.size)
    end

    it 'raises error when there is more attempts than allowed' do
      expect do
        described_class.new.create_rolls(['10'] * 22)
      end.to raise_error(TenPinRollFactory::InvalidNumberOfAttemptsError)
    end

    it 'raises error when there is more attempts lower than allowed' do
      expect do
        described_class.new.create_rolls(['10'] * 10)
      end.to raise_error(TenPinRollFactory::InvalidNumberOfAttemptsError)
    end
  end
end
