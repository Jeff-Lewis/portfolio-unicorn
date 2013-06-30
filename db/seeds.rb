# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# create the exchanges we support
%w(nasdaq nyse amex).each do |name|
  Exchange.create(name: name)
end
