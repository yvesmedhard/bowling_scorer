class TenPinGameFactory
  include GameFactory

  def create_games(data_input)
    data_input.map do |player, attempts|
      create_game(player, attempts)
    end
  end

  private

  def create_game(player, attempts)
    TenPinGame.new(player, attempts)
  end
end
