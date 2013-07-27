class Yahoo::Fundamentals::Job
  include Loggable
  include Reporting

  # Will import fundamentals for the securities on `exchange_name`
  # You can pass the following options:
  # :batch_size - to change the batch size (default to Yahoo::BATCH_SIZE)
  # :security_ids - import only the fundamentals for the specified securities instead of the whole exchange
  def initialize(exchange_name, options = {})
    @options = default_options.merge(options)
    @exchange_name = exchange_name
  end
  
  def before(job)
    logger.info "starting import fundamentals job for #{@exchange_name}"
  end

  def perform
    i = 0
    securities.find_in_batches(batch_size: batch_size) do |group|
      logger.info "Processing batch #{i}/#{batch_count}"
      fundamentals = Yahoo::Client.new(group).fundamentals
      logger.info "#{fundamentals}"
      i+= 1
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
    def default_options
      {batch_size: Yahoo::BATCH_SIZE, security_ids: nil}
    end

    def exchange
      @exchange ||= Exchange.find_by(name: @exchange_name)
    end

    def securities
      if @securities.nil?
        @securities = Security.where(exchange: exchange)
        unless @options[:security_ids].nil?
          @securities = @securities.where(id: @options[:security_ids])
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
      @options[:batch_size]
    end

    def gather_results(importer)
      new_items.add(importer.new_items)
      updated_items.add(importer.updated_items)
      unchanged_items.add(importer.unchanged_items)
      failed_items.add(importer.failed_items)
    end
end