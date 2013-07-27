class Sector < ActiveRecord::Base
  include InsensitiveUniqueField
  belongs_to :industry

  validates :industry_id, presence: true
  insensitive_unique :name

end
