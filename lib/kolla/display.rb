module Kolla
  class Display
    attr_accessor :output, :tab_size, :tab_character, :indent_count
    def initialize(
      output: Kolla.config.output,
      tab_size: Kolla.config.tab_size,
      tab_character: Kolla.config.tab_character
    )
      self.output = output
      self.tab_size = tab_size
      self.tab_character = tab_character
      self.indent_count = 0
    end

    def self.start
      yield(new)
    end

    def tab
      tab_character * tab_size
    end

    def indentation
      tab * indent_count
    end

    def line(*args)
      output.puts("#{indentation}#{Paint[*args]}")
    end

    def empty_line
      output.puts
    end

    def hide_cursor
      output.print("\x1b[?25l")
    end

    def show_cursor
      output.print("\x1b[?25h")
    end

    def spinner(options = {}, &block)
      Spinner.start({ before_animation: indentation }.merge(options), &block)
    end

    def progress(options = {}, &block)
      options[:title] = "#{indentation}#{options[:title]}"
      Progress.start(options.merge(display: self), &block)
    end

    def table(options = {}, &block)
      Table.new(options, &block).to_s.split("\n").map { |l| line(l) }
    end

    def indent(times = 1, &block)
      self.indent_count += 1 * times
      yield
      self.indent_count -= 1 * times
    end
  end
end
