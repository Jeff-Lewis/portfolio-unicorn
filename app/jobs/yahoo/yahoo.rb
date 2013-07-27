module Yahoo

#should create 2 types of request:
# - fundamentals: market cap, 52weeks hilo, EPS, PE, Dividend
# - tick date: OHLCV + date

  BATCH_SIZE = 150 #to avoid having url too long that get rejected by yahoo
  CSV_Mapping = {
    's' => 'Symbol',
    'x' => 'Stock Exchange',
    'n' => 'Name',

    'd1' => 'Last Trade Date',
    'd2' => 'Trade Date',

    'a' => 'Ask',
    'b' => 'Bid',

    'b2' => 'Ask (Real-time)',
    'b3' => 'Bid (Real-time)',

    'o' => 'Open',
    'p' => 'Previous Close',

    'g' => "Day's Low",
    'h' => "Day's High",
    'm' => "Day's Range",
    'm2' => "Day's Range (Real-time)",

    'k2' => 'Change Percent (Real-time)',

    'p2' => 'Change in Percent',

    'j3' => 'Market Cap (Real-time)',
    'j1' => 'Market Capitalization',

    'a2' => 'Average Daily Volume',
    'v' => 'Volume',

    'j' => '52-week Low',
    'k' => '52-week High',

    'e' => 'Earnings/Share',
    'r' => 'P/E Ratio',
    'y' => 'Dividend Yield',
    'r1' => 'Dividend Pay Date',

    'e1' => 'Error Indication (returned for symbol changed / invalid)'
  }

  QUOTE_KEYS = ['s', 'x', 'd1', 'd2', 'a', 'b', 'b2', 'b3', 'o', 'p', 'g', 'h', 'm', 'm2', 'k2', 'p2', 'v', 'e1']
  FUNDAMENTALS_KEYS = ['s', 'x', 'j3', 'j1', 'a2', 'j', 'k', 'e', 'r', 'y', 'r1', 'e1']
end