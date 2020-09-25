require 'paint'
require 'progressbar'
require 'terminal-table'
require 'json'
require 'ostruct'

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
  d.line('Calculating how big of a virgin you are...')
  d.indent do
    d.spinner(status: 'Calculating age', complete: 'Done!') { sleep 0.5 }
    d.spinner(status: 'Calculating sex', complete: 'Done!') { sleep 0.2 }
    d.spinner(status: 'Calculating height', complete: 'Done!') { sleep 0.3 }

    d.empty_line

    d.indent do
      d.line('Whatever my dudes...')
      d.spinner(status: 'Calculating height', complete: 'Done!') do |s|
        sleep 0.1
        s.animation.interval = 200
        sleep 2
      end
      d.progress(title: 'Dog') do |p|
        50.times do
          p.increment
          p.title = 'chicken'
          sleep 0.25
        end
      end
      d.table { |t| t << ['one', 1] }
    end

    d.line('sup')
  end
end

# Kolla.config { |c| c.spinner = { class: Kolla::Spinner, animation: :dots1 } }
