module Kolla
  class Display
    attr_accessor :output, :tab_size, :tab_character, :indent_count
    def initialize(output: $stdout, tab_size: 2, tab_character: ' ')
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

    def puts(*args)
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
      Progress.start(options, &block)
    end

    def table(options = {}, &block)
      table =
        Terminal::Table.new(options, &block).to_s.split("\n").map do |line|
          puts line
        end
    end

    def indent(times = 1, &block)
      self.indent_count += 1 * times
      yield
      self.indent_count -= 1 * times
    end
  end
end
