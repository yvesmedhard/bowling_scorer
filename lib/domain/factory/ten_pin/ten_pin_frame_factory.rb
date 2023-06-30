class TenPinFrameFactory < FrameFactory
  class InvalidFrameSequenceError < StandardError; end

  def self.game_type
    GameType::TEN_PIN
  end

  def create_frames(rolls)
    frame_generator = TenPinFrameGenerator.new(rolls)
    raise InvalidFrameSequenceError if frame_generator.invalid_frames?

    frame_generator.frames
  end

  class << self
    def self.factory_for(_game_type)
      raise NotImplementedError, 'Should not be used on child classes'
    end
  end
end
