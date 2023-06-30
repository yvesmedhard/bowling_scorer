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
    it 'raise an NotImplementedError' do
      expect { TestFrame.new(nil, []).strike? }.to raise_error(NotImplementedError)
    end
  end

  describe '#spare?' do
    it 'raise an NotImplementedError' do
      expect { TestFrame.new(nil, []).spare? }.to raise_error(NotImplementedError)
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
