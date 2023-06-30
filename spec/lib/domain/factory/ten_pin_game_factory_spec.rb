require 'spec_helper'
require 'domain/game_type'
require 'domain/game'
require 'domain/roll'
require 'domain/frame'
require 'domain/ten_pin/ten_pin_game'
require 'domain/factory/game_factory'
require 'domain/factory/ten_pin/ten_pin_game_factory'

RSpec.describe TenPinGameFactory do
  describe '.game_type' do
    it 'returns GameType::TEN_PIN' do
      expect(described_class.game_type).to eq(GameType::TEN_PIN)
    end
  end

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
