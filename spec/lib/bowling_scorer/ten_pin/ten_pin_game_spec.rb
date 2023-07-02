require 'spec_helper'
require 'bowling_scorer/frame'
require 'bowling_scorer/roll'
require 'bowling_scorer/ten_pin/ten_pin_frame'
require 'bowling_scorer/ten_pin/ten_pin_roll'
require 'bowling_scorer/game'
require 'bowling_scorer/ten_pin/ten_pin_game'

RSpec.describe TenPinGame do
  describe '#initialize' do
    let(:player) { 'Alice' }
    let(:attempts) { %w[3 4 5 5 10 7 2 10 10 10 10 10 10 10 10] }

    it 'sets the player attribute' do
      game = described_class.new(player, attempts)
      expect(game.player).to eq(player)
    end

    it 'sets the rolls attribute' do
      game = described_class.new(player, attempts)
      expect(game.rolls.size).to eq(attempts.size)
    end

    it 'rolls are intances of Roll' do
      game = described_class.new(player, attempts)
      expect(game.rolls.first).to be_an_instance_of(TenPinRoll)
    end

    it 'sets the frames attribute' do
      game = described_class.new(player, attempts)
      expect(game.frames.size).to eq(10)
    end

    it 'frames are intances of Frame' do
      game = described_class.new(player, attempts)
      expect(game.frames.first).to be_an_instance_of(TenPinFrame)
    end

    it 'captures StandardError and raises it with player reference' do
      attempts = %w[3 4 5 5 10 7 2 10 10 10 10 10 10 10]
      expect { described_class.new(player, attempts) }.to raise_error(/.* for player #{player}/)
    end
  end
end
