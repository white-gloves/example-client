require 'unirest'
require 'logger'
require 'rainbow'

class CapabilityChecker
    attr_reader :uri
    attr_accessor :log

    def initialize(uri)
        @uri = uri
        @log = Logger.new(STDOUT)
    end

    def check
        log.info Rainbow("Calling #{capabilities_url}").blue
        log.info "Faking result for now"
        ['size', 'color', 'name']
    end

    def scope
      uri.path.split('/').last
    end

    private

    def capabilities_url
        "#{uri.scheme}://#{uri.host}/capabilities/#{scope}"
    end
end
