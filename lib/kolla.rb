require 'progressbar'
require 'terminal-table'
require 'json'

require 'kolla/version'
require 'kolla/utils'
require 'kolla/animation'
require 'kolla/spinner'
require 'kolla/progress'
require 'kolla/table'
require 'kolla/display'
require 'kolla/config'

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
