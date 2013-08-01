# encoding : utf-8

MoneyRails.configure do |config|

  # Register a custom currency
  #
  config.register_currency = {
    :priority            => 1,
    :iso_code            => "USD",
    :name                => "USD with subunit of 6 digits",
    :symbol              => "$",
    :symbol_first        => true,
    :subunit             => "micro",
    :subunit_to_unit     => 1000000,
    :thousands_separator => ".",
    :decimal_mark        => ","
  }

  config.default_currency = :usd

  # Set default bank object
  #
  # Example:
  # config.default_bank = EuCentralBank.new

  # Add exchange rates to current money bank object.
  # (The conversion rate refers to one direction only)
  #
  # Example:
  # config.add_rate "USD", "CAD", 1.24515
  # config.add_rate "CAD", "USD", 0.803115

  # To handle the inclusion of validations for monetized fields
  # The default value is true
  #
  config.include_validations = true

  # Default ActiveRecord migration configuration values for columns:
  #
  config.amount_column = { prefix: '',           # column name prefix
                           postfix: '_udollar',    # column name  postfix
                           column_name: nil,     # full column name (overrides prefix, postfix and accessor name)
                           type: :integer,       # column type
                           limit: 8,             # 64 bits
                           present: true,        # column will be created
                           null: false,          # other options will be treated as column options
                           default: nil
                         }
  
  config.currency_column = { prefix: '',
                             postfix: '_currency',
                             column_name: nil,
                             type: :string,
                             present: true,
                             null: false,
                             default: 'USD'
                           }

  # Set money formatted output globally.
  # Default value is nil meaning "ignore this option".
  # Options are nil, true, false.
  #
  # config.no_cents_if_whole = nil
  # config.symbol = nil
end
