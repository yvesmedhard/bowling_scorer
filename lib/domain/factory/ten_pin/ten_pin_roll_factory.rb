class TenPinRollFactory < RollFactory
  class InvalidNumberOfAttemptsError < StandardError; end

  def self.game_type
    GameType::TEN_PIN
  end

  def create_rolls(attempts)
    unless valid_rolls_size?(attempts)
      raise InvalidNumberOfAttemptsError, "Invalid number of rolls: #{attempts.size}. " \
                                          "Must be between #{TenPinRoll::MIN_ROLLS} and #{TenPinRoll::MAX_ROLLS}"
    end

    attempts.map do |attempt|
      create_roll(attempt)
    end
  end

  private

  def create_roll(attempts)
    TenPinRoll.new(attempts)
  end

  def valid_rolls_size?(attempts)
    attempts.size.between?(TenPinRoll::MIN_ROLLS, TenPinRoll::MAX_ROLLS)
  end

  class << self
    def self.factory_for(_game_type)
      raise NotImplementedError, 'Should not be used on child classes'
    end
  end
end
