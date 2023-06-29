require 'spec_helper'
require 'domain/game'
require 'domain/roll'
require 'domain/frame'

RSpec.describe Game do
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
      expect(game.rolls.first).to be_an_instance_of(Roll)
    end

    it 'sets the frames attribute' do
      game = described_class.new(player, attempts)
      expect(game.frames.size).to eq(10)
    end

    it 'frames are intances of Frame' do
      game = described_class.new(player, attempts)
      expect(game.frames.first).to be_an_instance_of(Frame)
    end

    context 'when the 10th frame is a strike' do
      it 'sets the 10th frame with 3 rolls' do
        game = described_class.new(player, %w[3 4 5 5 10 7 2 10 10 10 10 10 10 10 10])
        expect(game.frames.last.rolls.size).to eq(3)
      end

      it 'raises if the last frame has less than 3 rolls' do
        expect do
          described_class.new(player, %w[3 4 5 5 10 7 2 10 10 10 10 10 10 10])
        end.to raise_error(ArgumentError, /Invalid frames/)
      end
    end

    context 'when the 10th frame is a spare' do
      it 'sets the 10th frame with 3 rolls' do
        game = described_class.new(player, %w[3 4 5 5 10 7 2 10 10 10 10 10 7 3 10])
        expect(game.frames.last.rolls.size).to eq(3)
      end

      it 'raises if the last frame has less than 3 rolls' do
        expect do
          described_class.new(player, %w[3 4 5 5 10 7 2 10 10 10 10 10 7 3])
        end.to raise_error(ArgumentError, /Invalid frames/)
      end
    end

    it 'raises an ArgumentError if the number of rolls is less than 10' do
      expect { described_class.new(player, %w[3 4]) }.to raise_error(ArgumentError, /Invalid number of rolls/)
    end

    it 'raises an ArgumentError if the number of rolls is greater than 21' do
      expect { described_class.new(player, ['3'] * 22) }.to raise_error(ArgumentError, /Invalid number of rolls/)
    end

    it 'raises an ArgumentError if the frames are invalid' do
      expect do
        described_class.new(player, %w[F 4 5 5 10 7 2 10 10 10 10 10 10])
      end.to raise_error(ArgumentError, /Invalid frames/)
    end
  end
end
