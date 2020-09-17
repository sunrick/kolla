module Kolla
  # https://shiroyasha.svbtle.com/escape-sequences-a-quick-guide-1
  # https://en.wikipedia.org/wiki/ANSI_escape_code#CSI_codes

  SPINNERS = {
    default: { frames: %w[⣾ ⣽ ⣻ ⢿ ⡿ ⣟ ⣯ ⣷], interval: 50, stop: '✔' }
  }

  class Spinner
    attr_accessor :thread,
                  :stream,
                  :before_spinner,
                  :after_spinner,
                  :before_status,
                  :status,
                  :after_status,
                  :done,
                  :current_frame,
                  :config

    def initialize(
      stream: $stdout,
      before_spinner: nil,
      after_spinner: ' ',
      before_status: nil,
      status: nil,
      after_status: '... ',
      done: nil,
      spinner: :default
    )
      self.stream = stream
      self.before_spinner = before_spinner
      self.after_spinner = after_spinner
      self.before_status = before_status
      self.status = status
      self.after_status = after_status
      self.done = done

      self.current_frame = 0
      self.config = SPINNERS[spinner]
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
            sleep(interval)
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

    def render_frame(frame)
      print(
        "#{before_spinner}#{frame}#{after_spinner}#{before_status}#{status}#{
          after_status
        }"
      )
    end

    def render_current_frame
      clear_frame
      print(
        "#{before_spinner}#{frames[current_frame]}#{after_spinner}#{
          before_status
        }#{status}#{after_status}"
      )
      increment_frame
    end

    def increment_frame
      if current_frame + 1 < frames.length
        self.current_frame += 1
      else
        self.current_frame = 0
      end
    end

    def render_stop_frame
      print(
        "#{before_spinner}#{stop_frame}#{after_spinner}#{before_status}#{
          status
        }#{after_status}#{done}"
      )
    end

    def interval
      @interval ||= config[:interval] / 1_000.to_f
    end

    def frames
      config[:frames]
    end

    def stop_frame
      config[:stop]
    end
  end
end
