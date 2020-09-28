module Kolla
  class Config
    DEFAULT_OPTIONS = {
      display: { output: $stdout, tab_size: 2, tab_character: ' ' },
      spinner: { class: Kolla::Spinner, animation: :dots },
      animations:
        JSON.parse(
          File.read('./animations/default.json'),
          symbolize_names: true
        ),
      progress: {
        title: 'Progress',
        total: 100,
        starting_at: 0,
        progress_mark: '=',
        remainder_mark: ' ',
        format: '%t: |%B|',
        length: 80,
        smoothing: 0.1,
        throttle_rate: 0.01,
        unknown_progress_animation_steps: %w[=--- -=-- --=- ---=]
      },
      table: {
        style: {
          border_x: '-',
          border_y: '|',
          border_i: '+',
          border_top: true,
          border_bottom: true,
          padding_left: 1,
          padding_right: 1,
          margin_left: '',
          width: nil,
          alignment: nil,
          all_separators: false
        },
        headings: [],
        rows: [],
        title: nil
      }
    }

    attr_accessor :display, :spinner, :animations, :progress, :table

    def initialize(options = {})
      options = Utils.merge(options, DEFAULT_OPTIONS)

      self.display = options[:display]
      self.spinner = options[:spinner]
      self.animations = options[:animations]
      self.progress = options[:progress]
      self.table = options[:table]
      self.display = options[:display]
    end
  end
end
