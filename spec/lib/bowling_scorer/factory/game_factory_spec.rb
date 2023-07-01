require 'spec_helper'
require 'bowling_scorer/game_type'
require 'bowling_scorer/factory/game_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_game_factory'

RSpec.describe GameFactory do
  describe '.game_type' do
    it 'raises an error when called on the base class' do
      expect { ConcreteGameFactory.new.game_type }.to raise_error(NotImplementedError)
    end
  end

  describe '#create_games' do
    it 'raises an error when called on the base class' do
      data_input = { 'Alice' => %w[3 4 5 5 10 7 2 10 10 10 10 10 10 10 10] }

      expect { ConcreteGameFactory.new.create_games(data_input) }.to raise_error(NotImplementedError)
    end
  end
end

class ConcreteGameFactory
  include GameFactory
end
