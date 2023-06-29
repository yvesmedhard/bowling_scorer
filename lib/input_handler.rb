require 'optparse'

class InputHandler
  attr_reader :file_path, :input_data

  def initialize(args)
    @options = { file_path: nil }

    parse_cli_options!(args)
    validate_file_input(@options[:file_path])

    @file_path = @options[:file_path]
    @input_data = read_input_file(@options[:file_path])
  end

  private

  def options_parser
    @options_parser ||= @options_parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] -f FILE"
      opts.on('-f', '--file FILE.txt', 'Path to input text file') do |file_path|
        @options[:file_path] = file_path
      end
      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit 0
      end
    end.freeze
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

  def read_input_file(file_path)
    input_data = Hash.new { |hash, key| hash[key] = [] }
    File.foreach(file_path) do |line|
      values = line.chomp.split("\t")
      if values.size != 2
        puts 'Error: invalid input format'
        exit 1
      end
      input_data[values[0]] << values[1]
    end
    input_data
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
end
