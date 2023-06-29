class Game
  attr_reader :player, :frames, :rolls

  MAX_ROLLS = 21
  MIN_ROLLS = 11

  def initialize(player, attempts)
    @player = player.freeze
    @rolls = create_rolls(attempts)
    unless valid_rolls_size?
      raise ArgumentError, "Invalid number of rolls: #{rolls.size}. Must be between #{MIN_ROLLS} and #{MAX_ROLLS}"
    end

    @frames = create_frames(@rolls).freeze
  end

  private

  def create_rolls(attempts)
    attempts.map { |attempt| Roll.new(attempt) }
  end

  def create_frames(rolls)
    remaining_rolls = rolls.clone
    frames = []
    10.times { frames << create_frame(remaining_rolls, frames) }

    raise ArgumentError, 'Invalid frames' if invalid_frames?(frames, remaining_rolls)

    frames
  end

  def create_frame(remaining_rolls, frames)
    if invalid_last_frame_size?(remaining_rolls, frames)
      nil
    elsif strike?(remaining_rolls.first)
      create_strike_frame(remaining_rolls, frames)
    elsif spare?(*remaining_rolls[0..1])
      create_spare_frame(remaining_rolls, frames)
    else
      create_normal_frame(remaining_rolls, frames)
    end
  end

  def invalid_frames?(frames, remaining_rolls)
    frames.any?(&:nil?) || remaining_rolls.any?
  end

  def invalid_last_frame_size?(remaining_rolls, frames)
    (strike?(remaining_rolls.first) || spare?(remaining_rolls[0], remaining_rolls[1])) &&
      frames.size == 9 &&
      remaining_rolls.size != 3
  end

  def create_strike_frame(remaining_rolls, frames)
    if frames.size == 9
      Frame.new(frames.last, remaining_rolls.shift(3))
    else
      Frame.new(frames.last, [remaining_rolls.shift, remaining_rolls[0], remaining_rolls[1]])
    end
  end

  def create_spare_frame(remaining_rolls, frames)
    if frames.size == 9
      Frame.new(frames.last, remaining_rolls.shift(3))
    else
      Frame.new(frames.last, remaining_rolls.shift(2).push(remaining_rolls[0]))
    end
  end

  def create_normal_frame(remaining_rolls, frames)
    Frame.new(frames.last, remaining_rolls.shift(2))
  end

  def strike?(roll)
    roll.pins == 10
  end

  def spare?(roll1, roll2)
    roll1.pins + roll2.pins == 10
  end

  def valid_rolls_size?
    rolls.size >= MIN_ROLLS && rolls.size <= MAX_ROLLS
  end
end
