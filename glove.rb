
require 'uri'
require_relative 'lib/capability_resolver.rb'
require_relative 'lib/sensitivity_resolver.rb'

abort("No URI given") unless ARGV.count >= 1
candidate = ARGV[0]
abort("Given uri #{candidate} not valid") unless candidate =~ URI::regexp
uri = URI(candidate)

resolver = CapabilityResolver.new(uri)
resolver.resolve

query_params = uri.query
if query_params != nil
  sresolver = SensitivityResolver.new(query_params)
  sresolver.resolve
end
