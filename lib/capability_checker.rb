require 'unirest'
require 'logger'
require 'rainbow'
require 'awesome_print'

class CapabilityChecker
    attr_reader :uri
    attr_accessor :log

    def initialize(uri)
        @uri = uri
        @log = Logger.new(STDOUT)
    end

    def check
        log.info Rainbow("Calling #{capabilities_url}").blue
        result = Unirest.get(capabilities_url)
        log.debug "Got #{result.body['capabilities']}"
        result.body['capabilities']
    end

    def scope
      uri.path.split('/').last
    end

    private

    def capabilities_url
        "#{uri.scheme}://#{uri.host}:#{uri.port}/capabilities/#{scope}"
    end
end
