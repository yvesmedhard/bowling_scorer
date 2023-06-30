require 'spec_helper'
require 'domain/frame'
require 'domain/roll'

RSpec.describe Frame do
  describe '#previous_frame' do
    it 'returns current previous_frame' do
      expect(TestFrame.new(nil, []).previous_frame).to be_nil
    end
  end

  describe '#rolls' do
    it 'returns current rolls' do
      expect(TestFrame.new(nil, []).rolls).to eq([])
    end
  end

  describe '#pins_score' do
    it 'raise an NotImplementedError' do
      expect { TestFrame.new(nil, []).pins_score }.to raise_error(NotImplementedError)
    end
  end

  describe '#total_score' do
    it 'raise an NotImplementedError' do
      expect { TestFrame.new(nil, []).total_score }.to raise_error(NotImplementedError)
    end
  end

  describe '#strike?' do
    context 'when the first roll is a strike' do
      it 'returns true' do
        frame = build(:ten_pin_frame, :strike)
        expect(frame.strike?).to be true
      end
    end

    context 'when the frame is a spare' do
      it 'returns false' do
        frame = build(:ten_pin_frame, :spare)
        expect(frame.strike?).to be false
      end
    end

    context 'when the frame is not a strike or a spare' do
      it 'returns false' do
        frame = build(:ten_pin_frame)
        expect(frame.strike?).to be false
      end
    end
  end

  describe '#spare?' do
    context 'when the first roll is a strike' do
      it 'returns false' do
        frame = build(:ten_pin_frame, :strike)
        expect(frame.spare?).to be false
      end
    end

    context 'when the frame is a spare' do
      it 'returns true' do
        frame = build(:ten_pin_frame, :spare)
        expect(frame.spare?).to be true
      end
    end

    context 'when the frame is not a strike or a spare' do
      it 'returns false' do
        frame = build(:ten_pin_frame)
        expect(frame.spare?).to be false
      end
    end
  end

  describe '#first_roll' do
    it 'return the first roll of the frame' do
      rolls = build_list(:ten_pin_roll, 3, :strike)
      expect(TestFrame.new(nil, rolls).first_roll).to be rolls.first
    end
  end

  describe '#second_roll' do
    it 'return the first roll of the frame' do
      rolls = build_list(:ten_pin_roll, 3, :strike)
      expect(TestFrame.new(nil, rolls).second_roll).to be rolls[1]
    end
  end

  describe '#third_roll' do
    it 'return the first roll of the frame' do
      rolls = build_list(:ten_pin_roll, 3, :strike)
      expect(TestFrame.new(nil, rolls).third_roll).to be rolls[2]
    end
  end
end

class TestFrame
  include Frame
  def initialize(previous_frame, rolls)
    @previous_frame = previous_frame.freeze
    @rolls = rolls.freeze
  end
end
