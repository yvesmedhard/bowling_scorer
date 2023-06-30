require 'spec_helper'
require 'domain/game_type'
require 'domain/factory/game_factory'
require 'domain/factory/ten_pin/ten_pin_game_factory'

RSpec.describe GameFactory do
  describe '.factory_for' do
    it 'returns an instance of TenPinGameFactory' do
      instance = described_class.factory_for(GameType::TEN_PIN)

      expect(instance).to be_an_instance_of(TenPinGameFactory)
    end

    it 'raises an error when no implementation is found for parameter game type' do
      expect do
        described_class.factory_for('UnexistingGameType')
      end.to raise_error(GameFactory::UnsupportedGameTypeError)
    end
  end

  describe '.game_type' do
    it 'raises an error when called on the base class' do
      expect { described_class.game_type }.to raise_error(NotImplementedError)
    end
  end

  describe '#create_games' do
    it 'raises an error when called on the base class' do
      data_input = { 'Alice' => %w[3 4 5 5 10 7 2 10 10 10 10 10 10 10 10] }

      expect { described_class.new.create_games(data_input) }.to raise_error(NotImplementedError)
    end
  end
end
