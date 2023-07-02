class TenPinFrame
  include Frame
  def initialize(previous_frame, rolls)
    @previous_frame = previous_frame.freeze
    @rolls = rolls.freeze
  end

  def pins_score
    rolls.sum(&:pins)
  end

  def total_score
    return pins_score if previous_frame.nil?

    previous_frame.total_score + pins_score
  end
end
