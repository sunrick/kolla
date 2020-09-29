module Kolla
  class Display
    attr_accessor :options, :output, :tab_size, :tab_character, :indent_count
    def initialize(opts = {})
      self.options = Utils.merge(opts, Kolla.config.default_options)
      self.output = options[:display][:output]
      self.tab_size = options[:display][:tab_size]
      self.tab_character = options[:display][:tab_character]
      self.indent_count = 0
    end

    def self.start(&block)
      if block.arity == 0
        new.instance_eval(&block)
      else
        yield(new)
      end
    end

    def tab
      tab_character * tab_size
    end

    def indentation
      tab * indent_count
    end

    def line(value)
      output.puts("#{indentation}#{value}")
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

    def spinner(overrides = {}, &block)
      overrides =
        options[:spinner].merge({ before_animation: indentation }).merge(
          overrides
        )
      Spinner.start(overrides, &block)
    end

    def progress(overrides = {}, &block)
      overrides[:title] = "#{indentation}#{overrides[:title]}"
      overrides = options[:progress].merge(display: self).merge(overrides)
      Progress.start(overrides, &block)
    end

    def table(overrides = {}, &block)
      overrides = options[:table].merge(overrides)
      Table.new(overrides, &block).to_s.split("\n").map { |l| line(l) }
    end

    def indent(times = 1, &block)
      self.indent_count += 1 * times
      yield
      self.indent_count -= 1 * times
    end
  end
end
