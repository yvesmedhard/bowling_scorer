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
    if previous_frame.nil?
      pins_score
    else
      previous_frame.total_score + pins_score
    end
  end
end
