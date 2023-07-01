require 'spec_helper'
require 'bowling_scorer/factory/frame_factory'

RSpec.describe FrameFactory do
  describe '#create_frames' do
    it 'raises an error when called on the base class' do
      rolls = build_list(:ten_pin_roll, 12)
      expect { ConcreteFrameFactory.new.create_frames(rolls) }.to raise_error(NotImplementedError)
    end
  end
end

class ConcreteFrameFactory
  include FrameFactory
end
