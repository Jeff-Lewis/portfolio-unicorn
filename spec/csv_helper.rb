module Helpers
  def csv_apple_valid
    header + csv_apple_row_valid
  end

  def csv_apple_row_valid
    '"AAPL","Apple Inc.","413.5","388131361500","n/a","1980","Technology","Computer Manufacturing","http://www.nasdaq.com/symbol/aapl",'
  end

  def csv_apple_not_valid_empty_symbol
    header + csv_apple_row_not_valid
  end

  def csv_apple_row_not_valid
    '"","Apple Inc.","413.5","388131361500","n/a","1980","Technology","Computer Manufacturing","http://www.nasdaq.com/symbol/aapl",'
  end

  private
  def header
    '"Symbol","Name","LastSale","MarketCap","ADR TSO","IPOyear","Sector","Industry","Summary Quote",' + "\n"
  end

end