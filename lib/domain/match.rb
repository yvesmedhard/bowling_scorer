class Match
  attr_reader :games, :game_type

  def initialize(data_input, game_type)
    @game_type = game_type
    @games = GameFactory.factory_for(@game_type).create_games(data_input)
  end
end
