require 'optparse'
require 'require_all'
require_all 'lib/bowling_scorer'

class InputHandler
  include TenPinInputParser
  include OptionsConfiguration

  attr_reader :file_path, :game_type

  def initialize(args)
    @options = { file_path: nil, game_type: GameType::TEN_PIN }

    parse_cli_options!(args)
    validate_file_input(@options[:file_path])

    @file_path = @options[:file_path]
    @game_type = @options[:game_type]
  end

  def input_data
    @input_data ||= read_input_file(@file_path)
  end

  private

  def options_parser
    @options_parser ||= OptionParser.new do |options|
      configure_options!(options)
    end
  end

  def parse_cli_options!(args)
    options_parser.parse(args)
  rescue OptionParser::InvalidOption, OptionParser::MissingArgument => e
    puts e.message.capitalize
    puts options_parser
    exit 1
  end

  def validate_file_input(file_path)
    valitate_path_existence(file_path)
    validate_extension_name(file_path)
    validate_file_existence(file_path)
  end

  def valitate_path_existence(file_path)
    return true unless file_path.nil?

    puts "Error: -f/--file option is required#{"\n" * 2}"
    puts options_parser
    exit 1
  end

  def validate_extension_name(file_path)
    return true unless File.extname(file_path) != '.txt'

    puts "Error: input file must have a .txt extension#{"\n" * 2}"
    puts options_parser
    exit 1
  end

  def validate_file_existence(file_path)
    return true if File.exist?(file_path)

    puts "Error: input file does not exist#{"\n" * 2}"
    puts options_parser
    exit 1
  end

  def game_types
    GameType.constants.map { |c| GameType.const_get(c) }.join(', ')
  end
end
