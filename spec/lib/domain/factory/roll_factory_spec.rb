require 'spec_helper'
require 'bowling_scorer/game_type'
require 'bowling_scorer/factory/roll_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_roll_factory'

RSpec.describe RollFactory do
  describe '.factory_for' do
    it 'returns an instance of TenPinRollFactory' do
      instance = described_class.factory_for(GameType::TEN_PIN)

      expect(instance).to be_an_instance_of(TenPinRollFactory)
    end

    it 'raises an error when no implementation is found for parameter game type' do
      expect do
        described_class.factory_for('UnexistingGameType')
      end.to raise_error(RollFactory::UnsupportedGameTypeError)
    end
  end

  describe '.game_type' do
    it 'raises an error when called on the base class' do
      expect { described_class.game_type }.to raise_error(NotImplementedError)
    end
  end

  describe '#create_rolls' do
    it 'raises an error when called on the base class' do
      attempts = ['10'] * 12

      expect { described_class.new.create_rolls(attempts) }.to raise_error(NotImplementedError)
    end
  end
end
