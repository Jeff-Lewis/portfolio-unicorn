
class Nasdaq::Mapper
  include Loggable

  attr_reader :row

  def self.attributes_for(row, security = nil)
    mapper = self.new(row, security)
    mapper.process
  end

  def initialize(row, security = nil)
    @row = row
    @security = security
  end

  def process
    mapping.each do |attribute, mapping_options|
      transform = mapping_options[:transform]
      csv_value = row[mapping_options[:csv_col]]
      attribute_value = transform.nil? ? csv_value : transform.call(security, csv_value)
      security.send("#{attribute}=", attribute_value)
    end
    security
  end

  private
    def security
      @security ||= Security.new      
    end

    # /!\ Watch out /!\
    # the Sector and Industry column title are swaped in the nasdaq.com csv
    # the industry (on the website) matches the value in the column 'Sector'
    # and the sector matches the column 'Industry'
    # will just swap them whem importing
    def header
      @@header ||= ['Symbol', 'Name', 'LastSale', 'MarketCap', 'ADR TSO', 'IPOYEAR', 'Sector', 'Industry', 'Summary Quote']
    end

    def mapping
      @@mapping ||= {
        symbol: {csv_col: 0 , transform: ->(security, symbol){ symbol.downcase.gsub(/\^/, '-') }},

        name: {csv_col: 1},

        #NOT a typo, industr and sector are mistakenly swaped in the CSV (see above)
        industry: {
          csv_col: 6,
          transform: ->(security, industry) do
            if industry.nil? || industry.blank?
              logger.warn "NO INDUSTRY for #{security.symbol} in #{row}"
              return nil
            else
              Industry.find_or_create_by(name: industry.downcase)
            end
          end
        },

        sector: {
          csv_col: 7,
          transform:  ->(security, sector_name) do
            if security.industry.nil? || sector_name.blank?
              logger.warn "No Industry/Sector for #{security.symbol} in #{row}"
              return nil
            end

            sector = Sector.find_by('name = ? and industry_id = ?', sector_name.downcase, security.industry.id);
            if sector.nil?
              sector = Sector.create!(name: sector_name.downcase, industry: security.industry)
            end
            sector  
          end
        }
      }
    end
end