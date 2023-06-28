require 'spec_helper'
require 'input_handler'

RSpec.describe InputHandler do
  describe '#initialize' do
    context 'with valid arguments' do
      it 'sets the file_path attribute' do
        input_handler = described_class.new(['-f', 'valid_input.txt'])
        expect(input_handler.file_path).to eq('valid_input.txt')
      end
    end

    context 'with missing file argument' do
      it 'prints an error message and exits' do
        expect do
          described_class.new([])
        end.to output(%r{Error: -f/--file option is required}).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'with invalid file extension' do
      it 'prints an error message and exits' do
        expect do
          described_class.new(['-f',
                               'spec/fixtures/invalid_input.csv'])
        end.to output(/Error: input file must have a .txt extension/).to_stdout.and raise_error(SystemExit)
      end
    end
  end
end
