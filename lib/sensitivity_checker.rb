require 'unirest'
require 'logger'
require 'rainbow'
require 'awesome_print'

class SensitivityChecker
    attr_reader :query_params
    attr_accessor :log

    def initialize(query_params)
        @query_params = query_params
        @log = Logger.new(STDOUT)
    end

    def check
        requested_fields
    end

    private

    def requested_fields
      log.debug "Query #{query_params}"
      return [] unless query_params != nil
      
      arr_qp = query_params.split('&')

      i = 0
      while i < arr_qp.length  do
        value_index = arr_qp[i].index('=')-1
        arr_qp[i] = arr_qp[i][0..value_index]
        i +=1
      end

      log.debug "Got #{arr_qp}"
      arr_qp
    end
end
