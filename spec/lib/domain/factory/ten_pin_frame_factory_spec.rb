require 'spec_helper'
require 'bowling_scorer/roll'
require 'bowling_scorer/frame'
require 'bowling_scorer/game_type'
require 'bowling_scorer/ten_pin/ten_pin_roll'
require 'bowling_scorer/ten_pin/ten_pin_frame'
require 'bowling_scorer/factory/frame_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_frame_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_frame_generator'

RSpec.describe TenPinFrameFactory do
  describe '.game_type' do
    it 'returns GameType::TEN_PIN' do
      expect(described_class.game_type).to eq(GameType::TEN_PIN)
    end
  end

  describe '#create_frames' do
    context 'with all strike rolls' do
      it 'returns the frames' do
        build_list(:ten_pin_roll, 12, :strike)
        rolls = build_list(:ten_pin_roll, 12, :strike)
        frames = described_class.new.create_frames(rolls)
        expect(frames.size).to be(10)
      end

      it 'allows last frame to have 2 extra rolls' do
        build_list(:ten_pin_roll, 12, :strike)
        rolls = build_list(:ten_pin_roll, 12, :strike)
        frames = described_class.new.create_frames(rolls)
        expect(frames.last.total_score).to be(300)
      end
    end

    context 'when ending on a spare' do
      let(:rolls) do
        not_strike = build(:ten_pin_roll, :not_strike)
        build_list(:ten_pin_roll, 9, :strike)
          .push(not_strike)
          .push(build(:ten_pin_roll, :spare, first_roll_pins: not_strike.pins))
          .push(build(:ten_pin_roll))
      end

      it 'allows for 1 extra roll' do
        expect(described_class.new.create_frames(rolls).last.rolls.size).to be(3)
      end
    end

    context 'when all faults' do
      it 'generates the frames properly' do
        frames = described_class.new.create_frames(build_list(:ten_pin_roll, 20, :foul))
        expect(frames.size).to be(10)
      end
    end
  end
end
