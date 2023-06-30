module Frame
  attr_reader :previous_frame, :rolls

  def pins_score
    raise NotImplementedError, 'Should be implemented'
  end

  def total_score
    raise NotImplementedError, 'Should be implemented'
  end

  def strike?
    rolls.first.pins == 10
  end

  def spare?
    !strike? && rolls[0..1].sum(&:pins) == 10
  end

  def first_roll
    rolls.first
  end

  def second_roll
    rolls[1]
  end

  def third_roll
    return rolls[2] if spare? || strike?
  end
end
