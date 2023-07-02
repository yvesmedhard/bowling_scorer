module GameType
  class UnsupportedGameTypeError < StandardError; end

  def self.factories
    @factories ||= {
      'ten_pin' => TenPinGameFactory
    }
  end

  def self.default
    'ten_pin'
  end

  def self.factory_for(game_type)
    factory = factories[game_type]
    raise UnsupportedGameTypeError, "Unsupported game type: #{game_type}" if factory.nil?

    factory
  end
end
