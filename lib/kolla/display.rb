module Kolla
  class Display
    attr_accessor :stream, :tab_size, :tab_character, :indent_count
    def initialize(stream: $stdout, tab_size: 2, tab_character: ' ')
      self.stream = stream
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

    def indentor
      tab * indent_count
    end

    def puts(*args)
      stream.puts("#{indentor}#{Paint[*args]}")
    end

    def empty_line
      stream.puts
    end

    def spinner(options = {}, &block)
      Spinner.start({ before_animation: indentor }.merge(options), &block)
    end

    def indent(times = 1, &block)
      self.indent_count += 1 * times
      yield
      self.indent_count -= 1 * times
    end
  end
end
