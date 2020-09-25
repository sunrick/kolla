module Kolla
  class Table < Terminal::Table
    def initialize(options = {})
      super(Kolla.config.table.merge(options))
    end
  end
end
