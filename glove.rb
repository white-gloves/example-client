
require 'uri'
require_relative 'lib/capability_resolver.rb'

abort("No URI given") unless ARGV.count >= 1
candidate = ARGV[0]
abort("Given uri #{candidate} not valid") unless candidate =~ URI::regexp
uri = URI(candidate)

resolver = CapabilityResolver.new(uri)
resolver.resolve
