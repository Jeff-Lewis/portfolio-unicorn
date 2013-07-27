class Industry < ActiveRecord::Base
  include InsensitiveUniqueField
  has_many :industries

  insensitive_unique :name
end
