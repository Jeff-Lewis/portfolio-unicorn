module CSVHelper
  def csv_apple
    header + csv_apple_row
  end

  def csv_apple_row
    '"AAPL","Apple Inc.","413.5","388131361500","n/a","1980","Technology","Computer Manufacturing","http://www.nasdaq.com/symbol/aapl",'
  end

  def apple_row
    CSV.parse(csv_apple_row)[0]
  end

  def csv_apple_not_valid_empty_symbol
    header + csv_apple_row_not_valid
  end

  def csv_apple_row_not_valid
    '"","Apple Inc.","413.5","388131361500","n/a","1980","Technology","Computer Manufacturing","http://www.nasdaq.com/symbol/aapl",'
  end

  def csv_symbol_dash
    header + csv_symbol_dash_row
  end
  
  def csv_symbol_dash_row
    '"UTX^A","United Technologies Corporation","64.46","0","n/a","n/a","n/a","n/a","http://www.nasdaq.com/symbol/utx^a",'
  end

  def aapl_yahoo_quote
    '"AAPL","NasdaqNM",482.40,482.40,483.60,483.60,483.50,484.60,478.60,483.41,385.10,652.79,"N/A - -0.08%","-0.08%",438.8B,12829600,9245340,40.106,12.05,2.36,"Aug 15","N/A"\r\n'
  end

  private
  def header
    '"Symbol","Name","LastSale","MarketCap","ADR TSO","IPOyear","Sector","Industry","Summary Quote",' + "\n"
  end
end