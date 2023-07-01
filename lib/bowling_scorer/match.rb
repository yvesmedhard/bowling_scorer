class Match
  class UnsupportedGameTypeError < StandardError; end
  attr_reader :games, :game_type

  def initialize(data_input, game_type)
    @game_type = game_type
    @games = game_factory_for(@game_type).create_games(data_input)
  end

  def game_factory_for(game_type)
    factory = GameFactory.descendants.find { |klass| klass.game_type == game_type }
    raise UnsupportedGameTypeError, "Unsupported game type: #{game_type}" if factory.nil?

    factory.new
  end
end
