require 'spec_helper'
require 'domain/frame'
require 'domain/roll'
require 'domain/ten_pin/ten_pin_frame'
require 'domain/ten_pin/ten_pin_roll'
require 'domain/game'
require 'domain/ten_pin/ten_pin_game'

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
  end
end
