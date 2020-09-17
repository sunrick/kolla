require 'paint'
require 'kolla/version'
require 'kolla/spinner'
require 'kolla/display'

module Kolla
  class Error < StandardError; end
  # Your code goes here...
end

Kolla::Display.start do |d|
  d.indent do
    d.puts('Calculating how big of a virgin you are...')
    d.indent do
      d.spinner(status: 'Calculating age', done: 'Done!') { sleep 2 }
      d.spinner(status: 'Calculating sex', done: 'Done!') { sleep 3 }
      d.spinner(status: 'Calculating height', done: 'Done!') { sleep 1 }
    end
  end
end
