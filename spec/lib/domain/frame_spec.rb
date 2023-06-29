require 'spec_helper'
require 'domain/frame'
require 'domain/roll'

RSpec.describe Frame do
  describe '#initialize' do
    it 'sets the rolls attribute' do
      roll1 = build(:roll)
      roll2 = build(:roll, :not_spare, first_roll_pins: roll1.pins)
      frame = described_class.new(nil, [roll1, roll2])
      expect(frame.rolls).to eq([roll1, roll2])
    end

    it 'sets the previous_frame attribute to nil by default' do
      roll1 = build(:roll, :not_strike)
      roll2 = build(:roll, :not_spare)
      frame = described_class.new(nil, [roll1, roll2])
      expect(frame.previous_frame).to be_nil
    end

    it 'sets the previous_frame attribute when provided' do
      previous_frame = build(:frame)
      roll1 = build(:roll, :not_strike)
      roll2 = build(:roll, :not_spare, first_roll_pins: roll1.pins)
      frame = described_class.new(previous_frame, [roll1, roll2])
      expect(frame.previous_frame).to eq(previous_frame)
    end
  end

  describe '#pins_score' do
    context 'when the frame is a strike' do
      it 'returns the sum of the pins for each roll' do
        roll1 = build(:roll, :strike)
        roll2 = build(:roll)
        roll3 = build(:roll, :second_roll, first_roll_pins: roll2.pins)
        frame = described_class.new(nil, [roll1, roll2, roll3])
        expect(frame.pins_score).to eq(roll1.pins + roll2.pins + roll3.pins)
      end
    end

    context 'when the frame is a spare' do
      it 'returns the sum of the pins for each roll' do
        roll1 = build(:roll, :not_strike)
        roll2 = build(:roll, :spare, first_roll_pins: roll1.pins)
        roll3 = build(:roll)
        frame = described_class.new(nil, [roll1, roll2, roll3])
        expect(frame.pins_score).to eq(roll1.pins + roll2.pins + roll3.pins)
      end
    end

    context 'when the frame is not a strike or spare' do
      it 'returns the sum of the pins for each roll' do
        roll1 = build(:roll, :not_strike)
        roll2 = build(:roll, :not_spare, first_roll_pins: roll1.pins)
        frame = described_class.new(nil, [roll1, roll2])
        expect(frame.pins_score).to eq(roll1.pins + roll2.pins)
      end
    end
  end

  describe '#total_score' do
    context 'when the previous frame is nil' do
      it 'returns the pins score' do
        roll1 = build(:roll, :not_strike)
        roll2 = build(:roll, :not_spare, first_roll_pins: roll1.pins)
        frame = described_class.new(nil, [roll1, roll2])
        expect(frame.total_score).to eq(roll1.pins + roll2.pins)
      end
    end

    context 'when the previous frame is not nil' do
      it 'returns the sum of the pins score and the previous frame total score' do
        roll1 = build(:roll, :not_strike)
        roll2 = build(:roll, :not_spare)
        previous_frame = build(:frame)
        frame = described_class.new(previous_frame, [roll1, roll2])
        expect(frame.total_score).to eq(previous_frame.total_score + roll1.pins + roll2.pins)
      end
    end
  end

  describe '#strike?' do
    context 'when the first roll is a strike' do
      it 'returns true' do
        frame = build(:frame, :strike)
        expect(frame.strike?).to be true
      end
    end

    context 'when the frame is a spare' do
      it 'returns false' do
        frame = build(:frame, :spare)
        expect(frame.strike?).to be false
      end
    end

    context 'when the frame is not a strike or a spare' do
      it 'returns false' do
        frame = build(:frame)
        expect(frame.strike?).to be false
      end
    end
  end

  describe '#spare?' do
    context 'when the first roll is a strike' do
      it 'returns false' do
        frame = build(:frame, :strike)
        expect(frame.spare?).to be false
      end
    end

    context 'when the frame is a spare' do
      it 'returns true' do
        frame = build(:frame, :spare)
        expect(frame.spare?).to be true
      end
    end

    context 'when the frame is not a strike or a spare' do
      it 'returns false' do
        frame = build(:frame)
        expect(frame.spare?).to be false
      end
    end
  end
end
