module Frame
  attr_reader :previous_frame, :rolls

  def strike?
    raise NotImplementedError, 'Should be implemented'
  end

  def spare?
    raise NotImplementedError, 'Should be implemented'
  end

  def pins_score
    raise NotImplementedError, 'Should be implemented'
  end

  def total_score
    raise NotImplementedError, 'Should be implemented'
  end
end
