require 'require_all'
require_all 'lib/bowling_scorer'

class BowlingScorer
  def initialize(argsv)
    input_handler = InputHandler.new(argsv)
    @match = Match.new(input_handler.input_data, input_handler.game_type)
  rescue StandardError => e
    puts e.message
    exit 1
  end

  def render
    puts MatchSerializer.new(@match).serialize
  end
end
