require 'spec_helper'
require 'bowling_scorer/game_type'
require 'bowling_scorer/factory/game_factory'
require 'bowling_scorer/match'

RSpec.describe Match do
  describe '#initialize' do
    context 'when the game type is unsupported' do
      it 'raises an UnsupportedGameTypeError' do
        expect { described_class.new([], 'FOO') }.to raise_error(GameType::UnsupportedGameTypeError)
      end
    end

    context 'when the game type is supported' do
      let(:data_input) { { 'player1' => ['10'] * 12, 'player2' => ['4'] * 20 } }

      it 'creates the correct number of games' do
        match = described_class.new(data_input, GameType.default_game_type)
        expect(match.games.size).to eq(2)
      end
    end
  end
end
