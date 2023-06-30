class TenPinGameFactory < GameFactory
  def self.game_type
    GameType::TEN_PIN
  end

  def create_games(data_input)
    data_input.map do |player, attempts|
      create_game(player, attempts)
    end
  end

  private

  def create_game(player, attempts)
    TenPinGame.new(player, attempts)
  end

  class << self
    def self.factory_for(_game_type)
      raise NotImplementedError, 'Should not be used on child classes'
    end
  end
end
