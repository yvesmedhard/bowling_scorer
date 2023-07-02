require 'spec_helper'
require 'bowling_scorer/roll'
require 'bowling_scorer/frame'
require 'bowling_scorer/game_type'
require 'bowling_scorer/ten_pin/ten_pin_roll'
require 'bowling_scorer/ten_pin/ten_pin_frame'
require 'bowling_scorer/factory/frame_factory'
require 'bowling_scorer/factory/roll_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_roll_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_frame_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_frame_generator'

RSpec.describe TenPinFrameGenerator do
  describe '#initialize' do
    context 'when there are no rolls' do
      it 'raises TenPinFrameGenerator::InvalidRollsSequenceError' do
        expect { described_class.new([]) }.to raise_error(
          TenPinFrameGenerator::InvalidRollsSequenceError,
          /Wrong number of rolls/
        )
      end
    end

    context 'when there are invalid parameters type' do
      it 'raises TenPinFrameGenerator::InvalidRollsSequenceError' do
        expect { described_class.new([10] * 11) }.to raise_error(
          TenPinFrameGenerator::InvalidRollsSequenceError,
          /Rolls are of the wrong type/
        )
      end
    end

    context 'when there are more than 21 rolls' do
      it 'raises TenPinFrameGenerator::InvalidRollsSequenceError' do
        rolls = build_list(:ten_pin_roll, 22, attempt: '4')
        expect { described_class.new(rolls) }.to raise_error(
          TenPinFrameGenerator::InvalidRollsSequenceError,
          /Wrong number of rolls: #{rolls.size}/
        )
      end
    end

    context 'when there are less than 11 rolls' do
      it 'raises TenPinFrameGenerator::InvalidRollsSequenceError' do
        rolls = build_list(:ten_pin_roll, 10, attempt: '4')
        expect { described_class.new(rolls) }.to raise_error(
          TenPinFrameGenerator::InvalidRollsSequenceError,
          /Wrong number of rolls: #{rolls.size}/
        )
      end
    end

    context 'when the rolls sequence makes an invalid game' do
      it 'raises and error when missing a strike extra roll' do
        rolls = build_list(:ten_pin_roll, 18, attempt: '4')
        rolls << build_list(:ten_pin_roll, 2, :strike)
        expect { described_class.new(rolls.flatten) }.to raise_error(
          TenPinFrameGenerator::InvalidRollsSequenceError, /Invalid remaining rolls for last frame mark: 2/
        )
      end

      it 'raises and error when missing two strike extra rolls' do
        rolls = build_list(:ten_pin_roll, 18, attempt: '4')
        rolls << build(:ten_pin_roll, :strike)
        expect { described_class.new(rolls) }.to raise_error(
          TenPinFrameGenerator::InvalidRollsSequenceError, /Invalid remaining rolls for last frame mark: 1/
        )
      end

      it 'raises and error when missing spare extra roll' do
        rolls = build_list(:ten_pin_roll, 19, attempt: '4')
        rolls << build(:ten_pin_roll, :spare, first_roll_pins: 4)
        expect { described_class.new(rolls) }.to raise_error(
          TenPinFrameGenerator::InvalidRollsSequenceError, /Invalid remaining rolls for last frame mark: 2/
        )
      end

      it 'raises and error when frame pinfall is greater than 10' do
        rolls = build_list(:ten_pin_roll, 19, attempt: '4')
        rolls << build(:ten_pin_roll, attempt: '7')
        expect { described_class.new(rolls) }.to raise_error(
          TenPinFrameGenerator::InvalidRollsSequenceError, /Invalid frame pins combination: 11/
        )
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
