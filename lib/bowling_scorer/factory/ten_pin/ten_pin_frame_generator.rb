class TenPinFrameGenerator
  attr_reader :frames

  class InvalidRollsSequenceError < StandardError; end

  NUMBER_OF_FRAMES = 10
  EXTRA_ROLLS = 2

  def initialize(rolls)
    validate_rolls(rolls)

    @remaining_rolls = rolls.clone
    @frames = []

    frames << create_frame until done?
  end

  def invalid_frames?
    @frames.any?(&:nil?) || @remaining_rolls.any?
  end

  private

  def validate_rolls(rolls)
    raise InvalidRollsSequenceError, 'Rolls are of the wrong type' unless rolls.all? { |roll| roll.is_a?(TenPinRoll) }
    raise InvalidRollsSequenceError, "Wrong number of rolls: #{rolls.size}" unless valid_rolls_size?(rolls)
  end

  def done?
    @frames.size == NUMBER_OF_FRAMES
  end

  def create_frame
    validate_last_frame
    return create_mark_last_frame if mark? && last_frame?
    return create_strike_frame if strike?
    return create_spare_frame if spare?

    if invalid_pins?
      raise InvalidRollsSequenceError,
            "Invalid frame pins combination: #{@remaining_rolls[0..1].sum(&:pins)}"
    end

    create_normal_frame
  end

  def create_strike_frame
    TenPinFrame.new(frames.last, [@remaining_rolls.shift, @remaining_rolls[0], @remaining_rolls[1]])
  end

  def create_spare_frame
    TenPinFrame.new(frames.last, @remaining_rolls.shift(2).push(@remaining_rolls[0]))
  end

  def create_normal_frame
    TenPinFrame.new(frames.last, @remaining_rolls.shift(2))
  end

  def create_mark_last_frame
    TenPinFrame.new(frames.last, @remaining_rolls.shift(1 + EXTRA_ROLLS))
  end

  def validate_last_frame
    return unless invalid_last_frame?

    raise InvalidRollsSequenceError,
          "Invalid remaining rolls for last frame mark: #{@remaining_rolls.size}"
  end

  def invalid_last_frame?
    (strike? || spare?) &&
      last_frame? &&
      wrong_remaining_rolls?
  end

  def strike?
    @remaining_rolls.first.pins == 10
  end

  def spare?
    @remaining_rolls[0..1].sum(&:pins) == 10
  end

  def invalid_pins?
    @remaining_rolls[0..1].sum(&:pins) > 10
  end

  def mark?
    strike? || spare?
  end

  def last_frame?
    @frames.size + 1 == NUMBER_OF_FRAMES
  end

  def wrong_remaining_rolls?
    @remaining_rolls.size != (EXTRA_ROLLS + 1)
  end

  def valid_rolls_size?(rolls)
    rolls.size.between?(TenPinRollFactory::MIN_ROLLS, TenPinRollFactory::MAX_ROLLS)
  end
end
