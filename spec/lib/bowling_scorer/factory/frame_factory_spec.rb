require 'spec_helper'
require 'bowling_scorer/game_type'
require 'bowling_scorer/factory/frame_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_frame_factory'

RSpec.describe FrameFactory do
  describe '.factory_for' do
    it 'returns an instance of TenPinFrameFactory' do
      instance = described_class.factory_for(GameType::TEN_PIN)

      expect(instance).to be_an_instance_of(TenPinFrameFactory)
    end

    it 'raises an error when no implementation is found for parameter game type' do
      expect do
        described_class.factory_for('UnexistingGameType')
      end.to raise_error(FrameFactory::UnsupportedGameTypeError)
    end
  end

  describe '.game_type' do
    it 'raises an error when called on the base class' do
      expect { described_class.game_type }.to raise_error(NotImplementedError)
    end
  end

  describe '#create_frames' do
    it 'raises an error when called on the base class' do
      rolls = build_list(:ten_pin_roll, 12)
      expect { described_class.new.create_frames(rolls) }.to raise_error(NotImplementedError)
    end
  end
end
