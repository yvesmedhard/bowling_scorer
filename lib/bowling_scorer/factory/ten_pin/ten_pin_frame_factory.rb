class TenPinFrameFactory
  include FrameFactory

  class InvalidFrameSequenceError < StandardError; end

  def create_frames(rolls)
    frame_generator = TenPinFrameGenerator.new(rolls)
    raise InvalidFrameSequenceError if frame_generator.invalid_frames?

    frame_generator.frames
  end
end
