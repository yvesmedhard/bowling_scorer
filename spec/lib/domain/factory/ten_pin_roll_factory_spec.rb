require 'spec_helper'
require 'domain/roll'
require 'domain/game_type'
require 'domain/ten_pin/ten_pin_roll'
require 'domain/factory/roll_factory'
require 'domain/factory/ten_pin/ten_pin_roll_factory'

RSpec.describe TenPinRollFactory do
  describe '.game_type' do
    it 'returns GameType::TEN_PIN' do
      expect(described_class.game_type).to eq(GameType::TEN_PIN)
    end
  end

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
