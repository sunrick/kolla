module Kolla
  # https://shiroyasha.svbtle.com/escape-sequences-a-quick-guide-1
  # https://en.wikipedia.org/wiki/ANSI_escape_code#CSI_codes

  ANIMATIONS = {
    default: { frames: %w[⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷], interval: 50, stop_frame: '✔' },
    rickard: { frames: %w[1 2 3 4 5], interval: 50, stop_frame: '✔' }
  }

  class Animation
    attr_accessor :name, :frames, :interval, :stop_frame, :index
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

    def current_frame
      frames[index]
    end

    def frame_count
      @frame_length ||= frames.length
    end

    def next_frame
      if index + 1 < frame_count
        self.index += 1
      else
        self.index = 0
      end
    end
  end

  class Spinner
    attr_accessor :thread,
                  :stream,
                  :before_animation,
                  :animation,
                  :after_animation,
                  :before_status,
                  :status,
                  :after_status,
                  :complete

    def initialize(
      stream: $stdout,
      animation: :default,
      before_animation: nil,
      after_animation: ' ',
      before_status: nil,
      status: nil,
      after_status: '... ',
      complete: nil
    )
      self.stream = stream
      self.before_animation = before_animation
      self.animation = animation
      self.after_animation = after_animation
      self.before_status = before_status
      self.status = status
      self.after_status = after_status
      self.complete = complete
    end

    def animation=(value)
      @animation = Animation.new(value.is_a?(Hash) ? value : ANIMATIONS[value])
    end

    def self.start(options = {}, &block)
      new(options).start(&block)
    end

    def start
      hide_cursor

      self.thread =
        Thread.new do
          while true
            render_current_frame
            sleep(animation.interval)
          end
        end

      begin
        yield(self)
      ensure
        stop
      end
    end

    def stop
      thread.terminate
      clear_frame
      render_stop_frame
      show_cursor
      new_line
    end

    def hide_cursor
      print("\x1b[?25l")
    end

    def show_cursor
      print("\x1b[?25h")
    end

    def new_line
      stream.puts
    end

    def print(value)
      stream.print(value)
    end

    # Clear from cursor to beginning of line
    # Set cursor at beginning of line
    def clear_frame
      print("\e[1K\e[G")
    end

    def render_current_frame
      clear_frame
      print(
        "#{before_animation}#{animation.current_frame}#{after_animation}#{
          before_status
        }#{status}#{after_status}"
      )
      animation.next_frame
    end

    def render_stop_frame
      print(
        "#{before_animation}#{animation.stop_frame}#{after_animation}#{
          before_status
        }#{status}#{after_status}#{complete}"
      )
    end
  end
end
