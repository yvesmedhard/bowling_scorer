require 'spec_helper'
require 'domain/roll'

RSpec.describe Roll do
  describe '#pins' do
    it 'returns instance pins' do
      expect(TestRoll.new(3, '3').pins).to eq(3)
    end

    it 'returns instance attempt' do
      expect(TestRoll.new(3, '3').attempt).to eq('3')
    end
  end
end

class TestRoll
  include Roll
  def initialize(pins, attempt)
    @pins = pins
    @attempt = attempt
  end
end
