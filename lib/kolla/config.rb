module Kolla
  class Config
    attr_accessor :spinner,
                  :animations,
                  :progress,
                  :table,
                  :output,
                  :tab_size,
                  :tab_character

    def initialize(
      spinner: { class: Kolla::Spinner, animation: :dots },
      animations: JSON.parse(
        File.read('./animations/default.json'),
        symbolize_names: true
      ),
      progress: {},
      table: {},
      output: $stdout,
      tab_size: 2,
      tab_character: ' '
    )
      self.spinner = spinner
      self.animations = animations
      self.progress = progress
      self.table = table
      self.output = output
      self.tab_size = tab_size
      self.tab_character = tab_character
    end
  end
end
