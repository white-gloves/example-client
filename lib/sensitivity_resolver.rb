require_relative 'sensitivity_checker.rb'
require_relative 'sensitivity_store.rb'
require 'rainbow'

class SensitivityResolver
  attr_reader :sstore, :schecker, :log

  def initialize(query_params)
    @query_params = query_params
    @schecker = SensitivityChecker.new(query_params)
    @sstore = SensitivityStore.new
    @log = Logger.new(STDOUT)
  end

  def resolve
    log.info(Rainbow(" *** Sensitivity check being performed...").red)
    requested = requested_sensitive_info.to_set
    disallowed = disallowed_sensitive_info.to_set
    requested_sensitive = requested.intersection(disallowed)
    allowed = requested - requested_sensitive
    requested_sensitive.each do |capability|
     log.warn(Rainbow("#{capability} requested but sensitive information").red.bg(:yellow).bright)
    end
    log.info(Rainbow("The allowed insensitive information: #{allowed.to_a}").green)
    allowed.to_a
  end

  private

  def requested_sensitive_info
    schecker.check
  end

  def disallowed_sensitive_info
    sstore.get()
  end
end
