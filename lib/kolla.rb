require 'paint'
require 'progressbar'
require 'terminal-table'
require 'json'

require 'kolla/version'
require 'kolla/config'
require 'kolla/animation'
require 'kolla/spinner'
require 'kolla/progress'
require 'kolla/table'
require 'kolla/display'

module Kolla
  class Error < StandardError; end
  extend self

  def config
    if block_given?
      @config = yield(Config.new)
    else
      @config ||= Config.new
    end
  end
end

Kolla::Display.start do |d|
  d.puts('Calculating how big of a virgin you are...')
  d.indent do
    d.spinner(status: 'Calculating age', complete: 'Done!') { sleep 2 }
    d.spinner(status: 'Calculating sex', complete: 'Done!') { sleep 3 }
    d.spinner(status: 'Calculating height', complete: 'Done!') { sleep 1 }

    d.empty_line

    d.indent do
      d.puts('Whatever my dudes...')
      d.spinner(status: 'Calculating height', complete: 'Done!') do |s|
        sleep 2
        s.animation.interval = 200
        sleep 3
      end
      d.progress do |p|
        50.times do
          p.increment
          sleep 0.25
        end
      end
      d.table { |t| t << ['one', 1] }
    end

    d.puts('sup')
  end
end

# Kolla.config { |c| c.spinner = { class: Kolla::Spinner, animation: :dots1 } }
