require 'csv'
require 'exceptions'

module Nasdaq
  class Importer
    include Loggable
    
    attr_reader :exchange
    attr_reader :csv_data
    attr_reader :imported_securities
    attr_reader :updated_securities
    attr_reader :deactivated_securities
    attr_reader :failed_lines

    def initialize(exchange_name, csv_data)
      @exchange = Exchange.find_by_name(exchange_name)
      raise Exceptions::ExchangeNotFoundError if @exchange.nil?

      @csv_data = csv_data
      @rows = CSV.parse(@csv_data);
      clear_fields
    end

    def import
      (1..@rows.size - 1).each do |i|
        process_row(@rows[i])
      end

      deactivate_delisted_securities
    end

    private
    def process_row(row)
      importer = ImporterIndividual.new(@exchange, row)
      security = importer.import

      @all_csv_symbols << importer.symbol
      case importer.status
      when :created
        logger.info "inserting new security: #{security.inspect}"
        @imported_securities << security

      when :updated
        logger.info "updating existing security: #{security.inspect}"
        @updated_securities << security

      when :failed
        logger.error "failed saving row...:excetion=#{importer.exception.inspect}, row=#{row}"
        @failed_lines << row

      when :no_changes
        logger.info "no change for #{importer.symbol}... NOP"
      end
    end

    def deactivate_delisted_securities
      securities_to_deactivate = Security.where("exchange_id = (?) and symbol NOT IN (?)",@exchange.id, @all_csv_symbols)
      securities_to_deactivate.update_all({active: false})
      @deactivated_securities = securities_to_deactivate
    end

    def clear_fields
      @imported_securities = []
      @updated_securities = []
      @failed_lines = []
      @all_csv_symbols = []
      @deactivated_securities = []
    end
  end
end