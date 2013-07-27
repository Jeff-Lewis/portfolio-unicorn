class Nasdaq::Job
  include Loggable

  def initialize(exchange_name)
    @exchange_name = exchange_name
  end
  
  def before(job)
    logger.info "starting import securities job for #{@exchange_name}"
  end

  def perform
    logger.info "downloading csv data..."
    csv_data = Nasdaq::Client.new(@exchange_name).companies
    logger.info "csv data downloaded..."
    logger.info "parsing csv data..."
    @importer = Nasdaq::Importer.new(@exchange_name, csv_data)
    @importer.import
  end
   
  def success(job)
  end
   
  def error(job, exception)
    logger.error "error #{exception}"
  end
   
  def after(job)
    logger.info "Import #{@exchange_name} Summary"
    logger.info "---------------------------------"
    logger.info "Created: #{@importer.imported_securities.size}"
    logger.info "Updated: #{@importer.updated_securities.size}"
    logger.info "Deactivated:#{@importer.deactivated_securities.size}"
    @importer.deactivated_securities.each do |s|
      logger.info "   #{s.to_s}"
    end
    logger.info "Failed: #{@importer.failed_lines.size}"
    @importer.failed_lines.each do |l|
      logger.info "   #{l.to_s}"
    end
  end
   
  def failure(job)
  end
end
