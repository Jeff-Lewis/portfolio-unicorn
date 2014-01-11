class Yahoo::Price::Job
  include Loggable
  include Reporting

  # args is a hash where you can enter the following keys:
  # :exchange_name - will import prices for all the securities on a given exchange UNLESS security_ids is specified
  # :security_ids - import specified securities instead of the whole exchange
  # You MUST provide either :exchange_name or :security_ids
  #
  # :batch_size - to change the batch size (default to Yahoo::BATCH_SIZE)
  def initialize(args)
    @exchange_name = args[:exchange_name]
    @security_ids = args[:security_ids]

    if @exchange_name.nil && @security_ids.nil?
      raise Exceptions::MissingParameterError
    end

    if options[:batch_size].nil?
      @batch_size = Yahoo::BATCH_SIZE
    else
      @batch_size = options[:batch_size]
    end
  end
  
  def before(job)
    logger.info "starting import prices job for #{@exchange_name}"
  end

  def perform
    i = 0
    securities.find_in_batches(batch_size: batch_size) do |security_group|
      logger.info "Processing batch #{i}/#{batch_count}"
      
      quotes = Yahoo::Client.new(security_group).quotes

      importer = Yahoo::Price::Importer.new(security_group, quotes)
      importer.import

      i += 1
    end
  end
   
  def success(job)
  end
   
  def error(job, exception)
    logger.error "error #{exception}"
    logger.error "#{exception.backtrace}"
  end
   
  def after(job)
  end
   
  def failure(job)
  end

  private
    def exchange
      @exchange ||= Exchange.find_by(name: @exchange_name)
    end

    def securities
      if @securities.nil?
        if @security_ids.nil?
          @securities = Security.where(exchange: exchange)
        else
          @securities = @securities.where(id: @security_ids)
        end
      end
      @securities
    end

    def total_securities
      @total_securities ||= securities.count
    end

    def batch_count
      (total_securities / batch_size).ceil
    end

    def batch_size
      @batch_size
    end

    def gather_results(importer)
      new_items.add(importer.new_items)
      updated_items.add(importer.updated_items)
      unchanged_items.add(importer.unchanged_items)
      failed_items.add(importer.failed_items)
    end
end