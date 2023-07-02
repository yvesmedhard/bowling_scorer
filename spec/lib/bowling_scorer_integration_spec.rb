require 'spec_helper'
require 'bowling_scorer'

RSpec.describe BowlingScorer do
  context 'when input file is valid' do
    let(:foul_game_output) { ['Jeff', pinfalls(['F'] * 20), scores(['0'] * 10)].join("\n") << "\n" }
    let(:normal_game_output) do
      ['Ana', pinfalls(
        ['', 'X', '7', '/', '9', '0', '', 'X', '0', '8', '8', '/', 'F', '6', '', 'X', '', 'X', '', 'X', '8', '1']
      ), scores(%w[20 39 48 66 74 84 90 120 148 167])].join("\n") << "\n"
    end
    let(:perfect_game_output) do
      ['Carl',
       pinfalls(((['', 'X'] * 10) << [10, 10])), scores(30.step(by: 30, to: 300).to_a)].join("\n") << "\n"
    end

    let(:spare_game_output) do
      ['Sacha', pinfalls((['5', '/'] * 10) << '5'),
       scores(15.step(by: 15, to: 150).to_a)].join("\n") << "\n"
    end
    let(:zero_game_output) { ['Liz', pinfalls(['0'] * 20), scores(['0'] * 10)].join("\n") << "\n" }

    context 'with fouls in all throwings' do
      it 'prints the game score to the stdout' do
        input_file = fixture('positive/foul_game.txt')
        expect do
          described_class.new(['-f', input_file.path]).render
        end.to output(with_header(foul_game_output)).to_stdout
      end
    end

    context 'with normal throwings' do
      it 'prints the game score to the stdout' do
        input_file = fixture('positive/normal_game.txt')
        expect do
          described_class.new(['-f', input_file.path]).render
        end.to output(with_header(normal_game_output)).to_stdout
      end
    end

    context 'with strikes in all throwings' do
      it 'prints the game score to the stdout' do
        input_file = fixture('positive/perfect_game.txt')
        expect do
          described_class.new(['-f', input_file.path]).render
        end.to output(with_header(perfect_game_output)).to_stdout
      end
    end

    context 'with spares in all frames' do
      it 'prints the game score to the stdout' do
        input_file = fixture('positive/spare_game.txt')
        expect do
          described_class.new(['-f', input_file.path]).render
        end.to output(with_header(spare_game_output)).to_stdout
      end
    end

    context 'with zero in all throwings' do
      it 'prints the game score to the stdout' do
        input_file = fixture('positive/zero_game.txt')
        expect do
          described_class.new(['-f', input_file.path]).render
        end.to output(with_header(zero_game_output)).to_stdout
      end
    end

    context 'with throwings ordered per player' do
      it 'prints the game score to the stdout' do
        multiplayer_output =
          [foul_game_output, normal_game_output, perfect_game_output, spare_game_output, zero_game_output].join
        expect do
          described_class.new(['-f', fixture('positive/multiplayer_ordered_game.txt').path]).render
        end.to output(with_header(multiplayer_output)).to_stdout
      end
    end

    context 'with throwings mixed' do
      it 'prints the game score to the stdout' do
        multiplayer_output =
          [foul_game_output, normal_game_output, perfect_game_output, spare_game_output, zero_game_output].join

        expect do
          described_class.new(['-f', fixture('positive/multiplayer_mixed_game.txt').path]).render
        end.to output(with_header(multiplayer_output)).to_stdout
      end
    end

    def with_header(output)
      [header, output].join("\n")
    end

    def header
      %w[Frame 1 2 3 4 5 6 7 8 9 10].join("\t\t")
    end

    def pinfalls(pins)
      ['Pinfalls', *pins].join("\t")
    end

    def scores(score)
      ['Score', *score].join("\t\t")
    end
  end

  context 'when input file is invalid' do
    context 'with empty file' do
      it 'outputs an error message and exits with status 1' do
        input_file = fixture('negative/empty_game.txt')
        expect { described_class.new(['-f', input_file.path]).render }.to output(
          /Error: empty input file\n/
        ).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'with an extra throwing' do
      it 'outputs an error message and exits with status 1' do
        input_file = fixture('negative/extra_throwing.txt')
        expect { described_class.new(['-f', input_file.path]).render }.to output(
          /Invalid remaining rolls for last frame mark: 4 for player Carl\n/
        ).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'with a missing throwing' do
      it 'outputs an error message and exits with status 1' do
        input_file = fixture('negative/missing_throwing.txt')
        expect { described_class.new(['-f', input_file.path]).render }.to output(
          /Invalid remaining rolls for last frame mark: 2 for player Jhon\n/
        ).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'with a invalid throwing' do
      it 'outputs an error message and exits with status 1' do
        input_file = fixture('negative/invalid_throwing.txt')
        expect { described_class.new(['-f', input_file.path]).render }.to output(
          /Invalid input: lorem for player Carl\n/
        ).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'with a negative throwing' do
      it 'outputs an error message and exits with status 1' do
        input_file = fixture('negative/negative_throwing.txt')
        expect { described_class.new(['-f', input_file.path]).render }.to output(
          /Invalid input: -5 for player Carl\n/
        ).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'with free text' do
      it 'outputs an error message and exits with status 1' do
        input_file = fixture('negative/free_text.txt')
        expect { described_class.new(['-f', input_file.path]).render }.to output(
          /Error: invalid input format: 'Lorem>*/
        ).to_stdout.and raise_error(SystemExit)
      end
    end

    context 'with invalid formatting' do
      it 'outputs an error message and exits with status 1' do
        input_file = fixture('negative/wrong_format.txt')
        expect { described_class.new(['-f', input_file.path]).render }.to output(
          /Error: invalid input format: 'Carl 10'\n/
        ).to_stdout.and raise_error(SystemExit)
      end
    end
  end

  # context 'when input file is invalid' do
  #   context 'with invalid characters present' do
  #     xit 'raises the corresponding error message' do
  #     end
  #   end

  #   context 'with invalid score' do
  #     xit 'raises the corresponding error message' do
  #     end
  #   end

  #   context 'with invalid number of throwings' do
  #     xit 'raises the corresponding error message' do
  #     end
  #   end
  # end
end
