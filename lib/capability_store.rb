require 'rainbow'

class CapabilityStore
  attr_accessor :log

  def initialize
    @log = Logger.new(STDOUT)
  end

  def get(scope = '')
    return [] unless scope == 'shoes'
    cap = ['color', 'size']
    log.debug Rainbow("Allowed capabilities #{cap}".blue)
    cap
  end
end
