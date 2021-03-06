module Kolla
  class Progress < ProgressBar::Base
    def self.start(options = {}, &block)
      new(options)._start(&block)
    end

    attr_accessor :display
    def initialize(options = {})
      self.display = options[:display]
      super(Kolla.config.progress.merge(options))
    end

    def title=(value)
      super("#{display&.indentation}#{value}")
    end

    def _start
      hide_cursor
      yield(self)
      show_cursor
      empty_line
    end

    def empty_line
      output.stream.puts
    end

    def hide_cursor
      output.stream.print("\x1b[?25l")
    end

    def show_cursor
      output.stream.print("\x1b[?25h")
    end
  end
end
