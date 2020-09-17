module Kolla
  ANIMATIONS = {
    default: { frames: %w[⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷], interval: 50, stop_frame: '✔' },
    rickard: { frames: %w[1 2 3 4 5], interval: 50, stop_frame: '✔' }
  }

  class Animation
    attr_accessor :name, :frames, :interval, :stop_frame, :index, :frame_count
    def initialize(name: nil, frames:, interval: 100, stop_frame: '✔', index: 0)
      self.name = name
      self.frames = frames
      self.interval = interval
      self.stop_frame = stop_frame
      self.index = index
    end

    def interval=(value)
      @interval = value / 1_000.to_f
    end

    def frames=(value)
      @frames = value
      self.frame_count = @frames.length
    end

    def current_frame
      frames[index]
    end

    def next_frame
      if index + 1 < frame_count
        self.index += 1
      else
        self.index = 0
      end
    end
  end
end
