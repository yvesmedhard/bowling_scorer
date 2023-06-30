module OptionsConfiguration
  def configure_options!(options_parser)
    configure_banner!(options_parser)
    configure_file_path_option!(options_parser)
    configure_game_type_option!(options_parser)
    configure_help_option!(options_parser)
  end

  private

  def configure_banner!(options_parser)
    options_parser.banner = "Usage: #{File.basename($PROGRAM_NAME)} [options] -f FILE"
  end

  def configure_file_path_option!(options_parser)
    options_parser.on('-f', '--file FILE.txt', '[required] Path to input text file') do |file_path|
      @options[:file_path] = file_path
    end
  end

  def configure_game_type_option!(options_parser)
    options_parser.on(
      '-m', '--mode TEXT', "The game type [#{game_types}]. Defaults to #{GameType::TEN_PIN}]"
    ) do |game_type|
      @options[:game_type] = game_type unless game_type.nil?
    end
  end

  def configure_help_option!(options_parser)
    options_parser.on('-h', '--help', 'Prints this help') do
      puts options_parser
      exit 0
    end
  end
end
