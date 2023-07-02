class TenPinGame
  include Game
  def initialize(player, attempts)
    @player = player.freeze
    @rolls = TenPinRollFactory.new.create_rolls(attempts)
    @frames = TenPinFrameFactory.new.create_frames(@rolls)
  rescue StandardError => e
    e.message << (" for player #{player}")
    raise e
  end
end
