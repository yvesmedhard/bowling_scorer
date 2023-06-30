require 'require_all'
require_all 'lib/domain'

begin
  input_handler = InputHandler.new(ARGV)

  match = Match.new(input_handler.input_data, input_handler.game_type)
  MatchPrinter.new(match).print
rescue StandardError => e
  puts e.message
end
