class TenPinGame
  include Game
  def initialize(player, attempts)
    @player = player.freeze
    @rolls = RollFactory.factory_for(GameType::TEN_PIN).create_rolls(attempts)
    @frames = FrameFactory.factory_for(GameType::TEN_PIN).create_frames(@rolls)
  end
end
