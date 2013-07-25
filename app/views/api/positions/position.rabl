attributes :id, :quantity, :created_at, :updated_at

node(:avg_price) {|position| position.avg_price.amount}

child :security do
  extends "securities/security"
end