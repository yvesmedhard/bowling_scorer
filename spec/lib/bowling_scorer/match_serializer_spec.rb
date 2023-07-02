require 'spec_helper'
require 'bowling_scorer/match_serializer'
require 'bowling_scorer/match'

RSpec.describe MatchSerializer do
  let(:valid_match_input_data) do
    {
      'Carl' => ['10'] * 12,
      'Jeff' => ['F'] * 20,
      'Liz' => ['0'] * 20,
      'Ana' => %w[10 7 3 9 0 10 0 8 8 2 F 6 10 10 10 8 1]
    }
  end

  describe '#serialize' do
    it 'returns a string' do
      match = Match.new(valid_match_input_data, GameType.default)
      serializer = described_class.new(match)
      expect(serializer.serialize).to be_a(String)
    end

    it 'returns a string with the correct header' do
      match = Match.new(valid_match_input_data, GameType.default)
      serializer = described_class.new(match)
      expect(serializer.serialize).to match(/#{%w[Frame 1 2 3 4 5 6 7 8 9 10].join("\t\t")}/)
    end

    it 'includes all player names' do
      match = Match.new(valid_match_input_data, GameType.default)
      serializer = described_class.new(match)
      expect(serializer.serialize).to include("Carl\n")
        .and(include("Jeff\n"))
        .and(include("Liz\n"))
        .and(include("Ana\n"))
    end

    it 'returns a string with the correct pinfalls for a perfect game' do
      match = Match.new(valid_match_input_data, GameType.default)
      serializer = described_class.new(match)
      expect(serializer.serialize).to match(
        /#{(%w[Pinfalls] << (['', 'X'] * 10) << [10, 10]).join("\t")}/
      )
    end

    it 'includes a string with the correct pinfalls for a foul game' do
      match = Match.new(valid_match_input_data, GameType.default)
      serializer = described_class.new(match)
      expect(serializer.serialize).to match(
        /#{(%w[Pinfalls] << (['F'] * 20)).join("\t")}/
      )
    end

    it 'includes a string with the correct pinfalls for a zero game' do
      match = Match.new(valid_match_input_data, GameType.default)
      serializer = described_class.new(match)
      expect(serializer.serialize).to match(
        /#{(%w[Pinfalls] << (['0'] * 20)).join("\t")}/
      )
    end

    it 'includes a string with the correct pinfalls for normal game' do
      expected = [
        'Pinfalls','', 'X', '7', '/', '9', '0', '', 'X', '0', '8', '8', '/', 'F', '6', '', 'X', '', 'X', '', 'X', '8', '1'
      ].join("\t")
      match = Match.new(valid_match_input_data, GameType.default)
      serializer = described_class.new(match)
      expect(serializer.serialize).to match(/#{expected}/)
    end
  end
end
