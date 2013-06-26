require 'securities_downloader'
require 'securities_importer'
require 'exceptions'

class ImportSecuritiesJob

  attr_reader :exchange_name
  attr_reader :imported_securities
  attr_reader :updated_securities
  attr_reader :failed_lines
  
  def initialize(exchange_name)
    @exchange_name = exchange_name
  end
  
  def before(job)
    logger.info "starting import securities job for #{@exchange_name}"
  end

  def perform
    logger.info "downloading csv data..."
    csv_data = SecuritiesDownloader.download(@exchange_name)
    logger.info "csv data downloaded..."
    logger.info "parsing csv data..."
    @importer = SecuritiesImporter.new(@exchange_name, csv_data)
    @importer.import
  end
   
  def success(job)
  end
   
  def error(job, exception)
    logger.error "error #{exception}"
  end
   
  def after(job)
    logger.info "Created #{@importer.imported_securities.size} new securities"
    logger.info "Updated #{@importer.updated_securities.size} existing securities"
    logger.info "Failed to process #{@importer.failed_lines.size} lines"
  end
   
  def failure(job)
  end

  private
  def logger
    Delayed::Worker.logger
  end
end
