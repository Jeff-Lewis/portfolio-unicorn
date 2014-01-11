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

    'b' => 'Bid',
    'a' => 'Ask',

    'b3' => 'Bid (Real-time)',
    'b2' => 'Ask (Real-time)',

    'o' => 'Open',
    'p' => 'Previous Close',

    'h' => "Day's High",
    'g' => "Day's Low",
    'm' => "Day's Range",
    'm2' => "Day's Range (Real-time)",

    'j' => '52-week Low',
    'k' => '52-week High',

    'k2' => 'Change Percent (Real-time)',
    'p2' => 'Change in Percent',

    'j1' => 'Market Capitalization',

    'a2' => 'Average Daily Volume',
    'v' => 'Volume',

    'e' => 'Earnings/Share',
    'r' => 'P/E Ratio',
    'y' => 'Dividend Yield',
    'r1' => 'Dividend Pay Date',

    'e1' => 'Error Indication (returned for symbol changed / invalid)'
  }

  KEYS = ['s', 'x', 
          'b', 'b3',
          'a', 'b2',
          'o', 'h', 'g', 'p',
          'j', 'k',
          'k2', 'p2',
          'j1',
          'a2', 'v',
          'e', 'r', 'y', 'r1',
          'e1']
end