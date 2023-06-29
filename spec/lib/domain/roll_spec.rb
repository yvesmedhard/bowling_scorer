require_relative '../../../lib/domain/roll'

RSpec.describe Roll do
  describe '#initialize' do
    context 'with valid input' do
      it 'sets the attempt attribute for a numeric input' do
        roll = Roll.new("3")
        expect(roll.attempt).to eq('3')
      end

      it 'sets the pins attribute for a numeric input' do
        roll = Roll.new("3")
        expect(roll.pins).to eq(3)
      end

      it 'sets the attempt attribute for an F input' do
        roll = Roll.new("F")
        expect(roll.attempt).to eq('F')
      end

      it 'sets the pins attribute to 0 for an F input' do
        roll = Roll.new("F")
        expect(roll.pins).to eq(0)
      end

      it 'raises an ArgumentError for an invalid input' do
        expect { Roll.new("11") }.to raise_error(ArgumentError, /Invalid input: 11/)
        expect { Roll.new("-1") }.to raise_error(ArgumentError, /Invalid input: -1/)
        expect { Roll.new("X") }.to raise_error(ArgumentError, /Invalid input: X/)
      end
    end
  end
end
