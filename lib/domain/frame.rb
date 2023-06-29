class Frame
  attr_reader :previous_frame, :rolls

  def initialize(previous_frame, rolls)
    @previous_frame = previous_frame.freeze
    @rolls = rolls.freeze
  end

  def pins_score
    rolls.sum(&:pins)
  end

  def total_score
    if previous_frame.nil?
      pins_score
    else
      previous_frame.total_score + pins_score
    end
  end

  def strike?
    rolls.first.pins == 10
  end

  def spare?
    !strike? && rolls[0..1].sum(&:pins) == 10
  end
end
