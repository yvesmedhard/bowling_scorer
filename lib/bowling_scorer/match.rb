class Match
  attr_reader :games

  def initialize(data_input, game_type)
    @games = GameType.factory_for(game_type).new.create_games(data_input)
  end
end
