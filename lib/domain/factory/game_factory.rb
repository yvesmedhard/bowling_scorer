class GameFactory
  class UnsupportedGameTypeError < StandardError; end

  def self.factory_for(game_type)
    factory = descendants.find { |klass| klass.game_type == game_type }
    raise UnsupportedGameTypeError, "Unsupported game type: #{game_type}" if factory.nil?

    factory.new
  end

  def self.game_type
    raise NotImplementedError
  end

  def create_games(data_input)
    raise NotImplementedError
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
