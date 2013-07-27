

class Nasdaq::ImporterIndividual
  include Loggable

  #will either be :created, :updated, :failed
  attr_reader :status

  #the CSV line to process
  attr_reader :csv

  #the resulting security, can be nil if the import failed
  attr_reader :security

  #if an error occurs when saving the record
  attr_reader :exception

  def initialize(exchange, csv)
    @exchange = exchange
    @csv = csv
  end

  def import
    logger.info "processing symbol #{symbol}"
    
    if security.nil?
      import_new_security
    else
      update_existing_security
    end
  end

  def symbol
    @symbol ||= @csv[0].downcase
  end

  private
    def security
      if @security.nil?
        @security = Security.find_by(exchange: @exchange, symbol: symbol)
        @status = @security.nil? ? :created : :updated
      end
      @security;
    end

    def import_new_security
      @security = Nasdaq::Mapper.attributes_for(csv)
      security.exchange_id = @exchange.id
      try_save
    end

    def update_existing_security
      @security = Nasdaq::Mapper.attributes_for(csv, security)
      unless @security.active?
        @security.active = true
      end
      try_save
    end

    def try_save
      begin
        if security.changed?
          security.save! 
        else
          @status = :no_changes
        end
      rescue ActiveRecord::ActiveRecordError => exception
        @exception = exception
        @security = nil
        @status = :failed
      end
      @security
    end
end