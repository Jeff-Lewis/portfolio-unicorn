attributes :id, :name, :symbol
node(:exchange) { |security| security.exchange.name }