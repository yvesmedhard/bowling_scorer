class TenPinRollFactory
  include RollFactory

  class InvalidNumberOfAttemptsError < StandardError; end

  MIN_ROLLS = 11
  MAX_ROLLS = 21

  def create_rolls(attempts)
    unless valid_rolls_size?(attempts)
      raise InvalidNumberOfAttemptsError, "Invalid number of rolls: #{attempts.size}. " \
                                          "Must be between #{MIN_ROLLS} and #{MAX_ROLLS}"
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
    attempts.size.between?(MIN_ROLLS, MAX_ROLLS)
  end
end
