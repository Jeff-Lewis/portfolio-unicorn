require 'csv'
require 'exceptions'

module Nasdaq
  class Importer
    include Loggable
    include Reporting

    attr_reader :exchange
    attr_reader :csv_data
    attr_reader :deactivated_securities

    def initialize(exchange_name, csv_data)
      @exchange = Exchange.find_by_name(exchange_name)
      raise Exceptions::ExchangeNotFoundError if @exchange.nil?

      @csv_data = csv_data
      @rows = CSV.parse(@csv_data);
    end

    def import
      (1..@rows.size - 1).each do |i|
        process_row(@rows[i])
      end
      deactivate_delisted_securities
    end

    def deactivated_securities
      @deactivated_securities ||= []
    end

    private
    def process_row(row)
      importer = ImporterIndividual.new(@exchange, row)
      security = importer.import

      all_csv_symbols << importer.symbol
      case importer.status
      when :created
        logger.info "inserting new security: #{security.inspect}"
        new_items << security

      when :updated
        logger.info "updating existing security: #{security.inspect}"
        updated_items << security

      when :failed
        logger.error "failed saving row...:excetion=#{importer.exception.inspect}, row=#{row}"
        failed_items << row

      when :no_changes
        logger.info "no change for #{importer.symbol}... NOP"
        unchanged_items << security
      end
    end

    def deactivate_delisted_securities
      securities_to_deactivate = Security.where("exchange_id = (?) and symbol NOT IN (?)",@exchange.id, all_csv_symbols)
      securities_to_deactivate.update_all({active: false})
      @deactivated_securities = securities_to_deactivate
    end

    def all_csv_symbols
      @all_csv_symbols ||= []
    end
  end
end