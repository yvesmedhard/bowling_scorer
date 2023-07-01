module GameFactory
  def game_type
    raise NotImplementedError
  end

  def create_games(data_input)
    raise NotImplementedError
  end

  def self.descendants
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end
end
