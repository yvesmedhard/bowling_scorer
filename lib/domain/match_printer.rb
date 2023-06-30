class MatchPrinter
  attr_reader :match

  def initialize(match)
    @match = match
  end

  def print
    puts header
    match.games.each do |game|
      puts player(game)
      puts pinfalls(game)
      puts scores(game)
    end
  end

  private

  def header
    %w[Frame 1 2 3 4 5 6 7 8 9 10].join("\t\t")
  end

  def player(game)
    game.player
  end

  def pinfalls(game)
    pinfalls = ['Pinfalls']
    game.frames.each_with_index do |frame, index|
      pinfalls << if last_frame?(index)
                    last_pinfall(frame)
                  elsif frame.strike?
                    strike
                  elsif frame.spare?
                    spare(frame)
                  else
                    normal(frame)
                  end
    end
    pinfalls.flatten.join("\t")
  end

  def scores(game)
    scores = ['Score']
    scores << game.frames.map(&:total_score)
    scores.flatten.join("\t\t")
  end

  def last_frame?(index)
    index == 9
  end

  def last_pinfall(frame)
    if frame.strike?
      strike + [frame.second_roll.attempt, frame.third_roll.attempt]
    elsif frame.spare?
      spare.push(frame.third_roll.attempt)
    else
      normal
    end
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
