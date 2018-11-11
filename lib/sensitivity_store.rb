require 'rainbow'

class SensitivityStore
  attr_accessor :log

  def initialize
    @log = Logger.new(STDOUT)
  end

  def get()
    sensitive_fields = ['dob', 'cc']
    log.debug Rainbow("Disallowed sensitive fields #{sensitive_fields}".blue)
    return sensitive_fields
  end
end
