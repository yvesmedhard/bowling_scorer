class TenPinFrameGenerator
  attr_reader :frames

  MAX_ROLLS = 21
  MIN_ROLLS = 11
  NUMBER_OF_FRAMES = 10
  EXTRA_ROLLS = 2

  def initialize(rolls)
    raise ArgumentError, 'Invalid rolls' unless valid_rolls?(rolls)

    @remaining_rolls = rolls.clone
    @frames = []

    frames << create_frame until done?
  end

  def invalid_frames?
    @frames.any?(&:nil?) || @remaining_rolls.any?
  end

  private

  def valid_rolls?(rolls)
    rolls.all? { |roll| roll.is_a?(TenPinRoll) } &&
      rolls.size.between?(MIN_ROLLS, MAX_ROLLS)
  end

  def done?
    @frames.size == NUMBER_OF_FRAMES
  end

  def create_frame
    return nil if invalid_last_frame?
    return create_mark_last_frame if mark? && last_frame?
    return create_strike_frame if strike?
    return create_spare_frame if spare?

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

  def invalid_last_frame?
    (@frames.size == NUMBER_OF_FRAMES) &&
      (strike? || spare?) &&
      last_frame?
  end

  def strike?
    @remaining_rolls.first.pins == 10
  end

  def spare?
    @remaining_rolls[0..1].sum(&:pins) == 10
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
end
