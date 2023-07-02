require 'require_all'
require_all 'lib/bowling_scorer'

begin
  input_handler = InputHandler.new(ARGV)

  match = Match.new(input_handler.input_data, input_handler.game_type)
  puts MatchSerializer.new(match).serialize
rescue StandardError => e
  puts e.message
end
