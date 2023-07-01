require 'spec_helper'
require 'bowling_scorer/roll'

RSpec.describe TenPinRoll do
  describe '#initialize' do
    context 'with valid input' do
      it 'sets the attempt attribute for a numeric input' do
        roll = described_class.new('3')
        expect(roll.attempt).to eq('3')
      end

      it 'sets the pins attribute for a numeric input' do
        roll = described_class.new('3')
        expect(roll.pins).to eq(3)
      end

      it 'sets the attempt attribute for an F input' do
        roll = described_class.new('F')
        expect(roll.attempt).to eq('F')
      end

      it 'sets the pins attribute to 0 for an F input' do
        roll = described_class.new('F')
        expect(roll.pins).to eq(0)
      end

      it 'raises an TenPinRoll::NotSupportedAttemptNotationError for an invalid input greater than 10' do
        input = Random.rand(11..999).to_s
        expect do
          described_class.new(input)
        end.to raise_error(TenPinRoll::NotSupportedAttemptNotationError, /Invalid input: #{input}/)
      end

      it 'raises an TenPinRoll::NotSupportedAttemptNotationError for an invalid input less than 0' do
        input = Random.rand(-999...0).to_s
        expect do
          described_class.new(input)
        end.to raise_error(TenPinRoll::NotSupportedAttemptNotationError, /Invalid input: #{input}/)
      end

      it 'raises an TenPinRoll::NotSupportedAttemptNotationError for an invalid character input' do
        input = ('A'..'Z').to_a.delete_if { |i| i == TenPinRoll::FOUL_INPUT }.sample
        expect do
          described_class.new(input)
        end.to raise_error(TenPinRoll::NotSupportedAttemptNotationError, /Invalid input: #{input}/)
      end
    end
  end
end
