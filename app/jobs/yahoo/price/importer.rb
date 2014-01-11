require 'smarter_csv'

class Yahoo::Price::Importer
  include Loggable
  include Reporting

  def initialize(securities, csv_data)
    @securities = securities
    @csv_data = csv_data
  end

  def import
    n = SmarterCSV.process(input, options) do |chunk|
      chunk.each do |l|
        p "#{l}"
      end
    end
  end

  def options
    {
      col_sep: ',',
      headers_in_file: false,
      user_provided_headers: headers,
      verbose: true
    }
  end

  def headers
    Yahoo::KEYS.map { |key| Yahoo::CSV_Mapping[key] }
  end

  private
    def input
      StringIO.new(@csv_data)
    end
 
end