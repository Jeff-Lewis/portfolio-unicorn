require 'csv'

class Yahoo::Fundamentals::Importer
  include Loggable
  include Reporting

  def initialize(securities, csv_data)
    @securities = securities
    @csv_data = csv_data
    logger.info csv_data
  end

  def import
    logger.info "#{rows.to_s}"
  end

  def rows
    @rows ||= CSV::parse(@csv_data)
  end
  
end