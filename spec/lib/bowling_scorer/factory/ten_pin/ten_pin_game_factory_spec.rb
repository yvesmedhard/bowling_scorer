require 'spec_helper'
require 'bowling_scorer/game_type'
require 'bowling_scorer/game'
require 'bowling_scorer/roll'
require 'bowling_scorer/frame'
require 'bowling_scorer/ten_pin/ten_pin_game'
require 'bowling_scorer/factory/game_factory'
require 'bowling_scorer/factory/ten_pin/ten_pin_game_factory'

RSpec.describe TenPinGameFactory do
  describe '#create_games' do
    context 'with single player valid data input' do
      let(:data_input) { { 'player' => ['10'] * 12 } }
      let(:games) { described_class.new.create_games(data_input) }

      it 'creates valid TenPinGame' do
        expect(games.first).to be_a(TenPinGame)
      end

      it 'create Game with valid player' do
        expect(games.first.player).to eq('player')
      end

      it 'create Game with valid frames' do
        expect(games.first.frames.size).to eq(10)
      end

      it 'create Game with valid rolls' do
        expect(games.first.rolls.size).to eq(12)
      end
    end

    context 'with multiple player valid data input' do
      let(:data_input) { { 'player1' => ['10'] * 12, 'player2' => ['4'] * 20 } }
      let(:games) { described_class.new.create_games(data_input) }

      it 'create valid quantity of games' do
        expect(games.size).to eq(2)
      end
    end
  end
end
