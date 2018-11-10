class CapabilityStore
  attr_accessor :log

  def initialize
    @log = Logger.new(STDOUT)
  end

  def get(scope = '')
    log.info("Faking store get")
    return [] unless scope == 'shoes'
    ['color', 'size']
  end
end
