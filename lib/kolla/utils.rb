module Kolla
  module Utils
    extend self

    def merge(new_options, default_options)
      default_options.dup.merge(new_options) do |key, default_value, new_value|
        if default_value.is_a?(Hash) && new_value.is_a?(Hash)
          merge(new_value, default_value)
        else
          new_value
        end
      end
    end
  end
end
