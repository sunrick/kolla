module Kolla
  # https://shiroyasha.svbtle.com/escape-sequences-a-quick-guide-1
  # https://en.wikipedia.org/wiki/ANSI_escape_code#CSI_codes
  class Spinner
    attr_accessor :thread,
                  :output,
                  :before_animation,
                  :animation,
                  :after_animation,
                  :before_status,
                  :status,
                  :after_status,
                  :complete

    def initialize(options = {})
      options = Kolla.config.spinner.merge(options)

      self.output = options[:output]
      self.before_animation = options[:before_animation]
      self.animation = options[:animation]
      self.after_animation = options[:after_animation]
      self.before_status = options[:before_status]
      self.status = options[:status]
      self.after_status = options[:after_status]
      self.complete = options[:complete]
    end

    def animation=(value)
      @animation =
        if value.is_a?(Animation)
          value
        elsif value.is_a?(Hash)
          Animation.new(value)
        else
          Animation.new(Kolla.config.animations[value])
        end
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
      line
    end

    def hide_cursor
      print("\x1b[?25l")
    end

    def show_cursor
      print("\x1b[?25h")
    end

    def line
      output.puts
    end

    def print(value)
      output.print(value)
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
