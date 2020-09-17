require 'paint'
require 'kolla/version'
require 'kolla/spinner'
require 'kolla/display'

module Kolla
  class Error < StandardError; end
  # Your code goes here...
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
    end
  end
end
