module Kolla
  class Config
    attr_accessor :spinner, :animations

    def initialize(
      spinner: { class: Kolla::Spinner, animation: :dots },
      animations: JSON.parse(
        File.read('./animations/default.json'),
        symbolize_names: true
      )
    )
      self.spinner = spinner
      self.animations = animations
    end
  end
end
