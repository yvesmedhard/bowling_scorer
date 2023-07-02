require 'spec_helper'
require 'bowling_scorer/ten_pin/ten_pin_input_parser'

RSpec.describe TenPinInputParser do
  describe '#read_input_file' do
    context 'when the input file is empty' do
      it 'raises an ArgumentError' do
        expect do
          ConcreteParser.new.read_input_file('spec/fixtures/negative/empty.txt')
        end.to raise_error(ArgumentError, 'Error: empty input file')
      end
    end

    context 'when the input file is not empty but has wrong format' do
      it 'raises an ArgumentError' do
        expect do
          ConcreteParser.new.read_input_file('spec/fixtures/negative/wrong-format.txt')
        end.to output(/Error: invalid input format/).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'when the input file is not empty' do
      it 'returns the input data' do
        expect(ConcreteParser.new.read_input_file(
                 'spec/fixtures/positive/perfect.txt'
               )).to eq({ 'Carl' => ['10'] * 12 })
      end
    end
  end
end

class ConcreteParser
  include TenPinInputParser
end
