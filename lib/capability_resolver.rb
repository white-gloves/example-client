require_relative 'capability_checker.rb'
require_relative 'capability_store.rb'
require 'rainbow'

class CapabilityResolver
  attr_reader :store, :checker, :log

  def initialize(uri)
    @uri = uri
    @checker = CapabilityChecker.new(uri)
    @store = CapabilityStore.new
    @log = Logger.new(STDOUT)
  end

  def resolve
    log.info(Rainbow(" *** Capability check being performed...").red)
    requested = requested_capabilities.to_set
    allowed = allowed_capabilities.to_set
    resolved = allowed.intersection(requested)
    disallowed = requested - allowed
    disallowed.each do |capability|
      log.warn(Rainbow("#{capability} requested but not allowed").red.bg(:yellow).bright)
    end
    log.info(Rainbow("The allowed search will use: #{resolved.to_a}").green)
    resolved.to_a
  end

  def scope
    checker.scope
  end

  private

  def requested_capabilities
    checker.check
  end

  def allowed_capabilities
    store.get(scope)
  end
end
