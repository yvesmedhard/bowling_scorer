require 'optparse'

class InputHandler
  attr_reader :file_path

  def initialize(args)
    @options = { file_path: nil }

    parse_cli_options!(args)
    validate_file_input(@options[:file_path])

    @file_path = @options[:file_path]
  end

  private

  def options_parser
    if @options_parser.nil?
      @options_parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{File.basename($0)} [options] -f FILE"
        opts.on('-f', '--file FILE.txt', 'Path to input text file') do |file_path|
          @options[:file_path] = file_path
        end
        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit 0
        end
      end
    else
      @options_parser
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
    if file_path.nil?
      puts "Error: -f/--file option is required#{"\n" * 2}"
      puts options_parser
      exit 1
    elsif File.extname(file_path) != '.txt'
      puts "Error: input file must have a .txt extension#{"\n" * 2}"
      puts options_parser
      exit 1
    end
  end
end
