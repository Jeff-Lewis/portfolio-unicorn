require 'csv'
require 'exceptions'

class SecuritiesImporter
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
    clear_fields
  end

  def import
    clear_fields
    @rows = CSV.parse(csv_data);
    @mapped_header = @rows[0].map {|c| mapping[c] || c }

    (1..@rows.size - 1).each do |i|
      process_row(@rows[i])
    end

    deactivate_delisted_securities
  end

  def mapping
    {'Symbol' => 'symbol', 'Name' => 'name'}
  end

  private
  def process_row(row)
    symbol = row[0].downcase
    logger.info "processing symbol #{symbol}"
    security = Security.find_by(exchange: @exchange, symbol: symbol)
    @all_csv_symbols << symbol

    if security.nil?
      import_new_security(row)
    else
      update_existing_security(security, row)
    end
  end

  def import_new_security(row)
    security = Security.new(build_attributes(row))
    security.exchange_id = @exchange.id
    logger.info "inserting new security: #{security.inspect}"
    try_save(security, row)
  end

  def update_existing_security(security, row)
    security.attributes = build_attributes(row)
    unless security.active?
      security.active = true
    end
    logger.info "updating existing security: #{security.inspect}"
    try_save(security, row)
  end

  def build_attributes(row)
    key_value_array = [@mapped_header, row].transpose
    attributes = Hash[key_value_array]
    attributes.slice(*Security.attribute_names)
  end

  def try_save(security, row)
    container = case
    when security.new_record?
      @imported_securities
    when security.changed?
      @updated_securities
    else nil
    end

    begin
      security.save! if security.changed?
      container << security unless container.nil?
    rescue ActiveRecord::ActiveRecordError => exception
      logger.error "failed saving row...:excetion=#{exception.inspect}, row=#{row}"
      @failed_lines << row
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

  def logger
    Delayed::Worker.logger
  end
end