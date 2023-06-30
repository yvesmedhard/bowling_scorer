class TenPinRoll
  include Roll

  class NotSupportedAttemptNotationError < StandardError; end

  VALID_INPUT_REGEX = /(^[0-9]$)|(F)|(^[1][0]$)/
  FOUL_INPUT = 'F'.freeze

  def initialize(attempt)
    raise NotSupportedAttemptNotationError, "Invalid input: #{attempt}" unless valid_input?(attempt)

    @attempt = attempt.freeze
    @pins ||= parse_pins(@attempt).freeze
  end

  private

  def parse_pins(attempt)
    attempt == FOUL_INPUT ? 0 : attempt.to_i
  end

  def valid_input?(attempt)
    attempt =~ VALID_INPUT_REGEX
  end
end
