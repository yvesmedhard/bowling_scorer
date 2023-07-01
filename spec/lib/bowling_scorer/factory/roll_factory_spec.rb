require 'spec_helper'
require 'bowling_scorer/factory/roll_factory'

RSpec.describe RollFactory do
  describe '#create_rolls' do
    it 'raises an error when called on the base class' do
      attempts = ['10'] * 12

      expect { ConcreteRollFactory.new.create_rolls(attempts) }.to raise_error(NotImplementedError)
    end
  end
end

class ConcreteRollFactory
  include RollFactory
end
