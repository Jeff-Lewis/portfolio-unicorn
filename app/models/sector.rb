# == Schema Information
#
# Table name: sectors
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  industry_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Sector < ActiveRecord::Base
  include InsensitiveUniqueField
  belongs_to :industry

  validates :industry_id, presence: true
  insensitive_unique :name, uniqueness: { scope: :industry_id, 
                                          case_sensitive: false,
                                          message: "Sector name should be unique per industry" }

end
