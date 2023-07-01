require 'spec_helper'
require 'bowling_scorer/roll'
require 'bowling_scorer/frame'
require 'bowling_scorer/game_type'
require 'bowling_scorer/ten_pin/ten_pin_roll'
require 'bowling_scorer/ten_pin/ten_pin_frame'
require 'bowling_scorer/factory/ten_pin/ten_pin_frame_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_frame_generator'

RSpec.describe TenPinFrameGenerator do
  describe '#initialize' do
    context 'when there are no rolls' do
      it 'raises ArgumentError' do
        expect { described_class.new([]) }.to raise_error(ArgumentError)
      end
    end

    context 'when there are invalid parameters' do
      it 'raises ArgumentError' do
        expect { described_class.new([10] * 11) }.to raise_error(ArgumentError)
      end
    end

    context 'when there are more than 21 rolls' do
      it 'raises ArgumentError' do
        rolls = build_list(:ten_pin_roll, 19, attempt: '4')
        rolls.push(build(:ten_pin_roll, :spare, first_roll_pins: 4))
        rolls.push(build_list(:ten_pin_roll, 2, :strike))
        expect { described_class.new(rolls) }.to raise_error(ArgumentError)
      end
    end

    context 'when there are less than 11 rolls' do
      it 'raises ArgumentError' do
        rolls = build_list(:ten_pin_roll, 10, attempt: '4')
        expect { described_class.new(rolls) }.to raise_error(ArgumentError)
      end
    end

    context 'when there are the maximum valid rolls' do
      it 'creates the frames properly' do
        rolls = build_list(:ten_pin_roll, 19, attempt: '4')
        rolls.push(build(:ten_pin_roll, :spare, first_roll_pins: 4))
        rolls.push(build(:ten_pin_roll, :strike))
        expect(described_class.new(rolls).frames.size).to eq(10)
      end

      it 'frames are not invalid' do
        rolls = build_list(:ten_pin_roll, 19, attempt: '4')
        rolls.push(build(:ten_pin_roll, :spare, first_roll_pins: 4))
        rolls.push(build(:ten_pin_roll, :strike))
        expect(described_class.new(rolls).invalid_frames?).to be false
      end
    end

    context 'when there are the minimum valid rolls' do
      it 'creates the frames properly' do
        rolls = build_list(:ten_pin_roll, 12, :strike)
        expect(described_class.new(rolls).frames.size).to eq(10)
      end

      it 'frames are not invalid' do
        rolls = build_list(:ten_pin_roll, 12, :strike)
        expect(described_class.new(rolls).invalid_frames?).to be false
      end
    end
  end
end
