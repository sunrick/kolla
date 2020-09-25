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

Kolla::Display.start do
  line('Calculating how big of a virgin you are...')
  indent do
    spinner(status: 'Calculating age', complete: 'Done!') { sleep 0.5 }
    spinner(status: 'Calculating sex', complete: 'Done!') { sleep 0.2 }
    spinner(status: 'Calculating height', complete: 'Done!') { sleep 0.3 }

    empty_line

    indent do
      line('Whatever my dudes...')
      spinner(status: 'Calculating height', complete: 'Done!') do |s|
        sleep 0.1
        s.animation.interval = 200
        sleep 2
      end
      progress(title: 'Dog') do |p|
        50.times do |i|
          p.increment
          sleep 0.25
        end
      end
      table { |t| t << ['one', 1] }
    end

    line('sup')
  end
end
