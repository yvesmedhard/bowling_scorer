class MatchSerializer
  def initialize(match)
    @match = match
  end

  def serialize
    output = ''
    output << to_line(header)
    @match.games.each do |game|
      output << to_line(player(game))
      output << to_line(pinfalls(game))
      output << to_line(scores(game))
    end
    output
  end

  private

  def to_line(string)
    "#{string}\n"
  end

  def header
    %w[Frame 1 2 3 4 5 6 7 8 9 10].join("\t\t")
  end

  def player(game)
    game.player
  end

  def pinfalls(game)
    pinfalls = ['Pinfalls']
    game.frames.each_with_index do |frame, index|
      pinfalls << create_pinfall(frame, index)
    end

    pinfalls.flatten.join("\t")
  end

  def scores(game)
    scores = ['Score']
    scores << game.frames.map(&:total_score)
    scores.flatten.join("\t\t")
  end

  def create_pinfall(frame, index)
    return last_pinfall(frame) if last_frame?(index)
    return strike if frame.strike?
    return spare(frame) if frame.spare?

    normal(frame)
  end

  def last_frame?(index)
    index == 9
  end

  def last_pinfall(frame)
    return strike + [frame.second_roll.attempt, frame.third_roll.attempt] if frame.strike?
    return spare(frame).push(frame.third_roll.attempt) if frame.spare?

    normal(frame)
  end

  def strike
    ['', 'X']
  end

  def spare(frame)
    [frame.first_roll.attempt, '/']
  end

  def normal(frame)
    [frame.first_roll.attempt, frame.second_roll.attempt]
  end
end
