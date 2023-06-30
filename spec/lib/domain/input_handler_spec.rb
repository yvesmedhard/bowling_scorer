require 'spec_helper'
require 'domain/input_handler'

RSpec.describe InputHandler do
  describe '#initialize' do
    context 'with valid arguments' do
      it 'sets the file_path attribute' do
        input_handler = described_class.new(['-f', 'spec/fixtures/positive/perfect.txt'])
        expect(input_handler.file_path).to eq('spec/fixtures/positive/perfect.txt')
      end

      it 'sets the input_data attribute with file contents' do
        input_handler = described_class.new(['-f', 'spec/fixtures/positive/perfect.txt'])
        expected = {
          'Carl' => ['10'] * 12
        }
        expect(input_handler.input_data).to eq(expected)
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

    context 'with non-existent file path' do
      it 'prints an error message and exits' do
        expect do
          described_class.new(['-f', 'spec/fixtures/nonexistent_input.txt'])
        end.to output(/Error: input file does not exist/).to_stdout.and raise_error(SystemExit)
      end
    end
  end
end
