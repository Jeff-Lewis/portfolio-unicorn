# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Exchange < ActiveRecord::Base
  has_many :securities

  validates :name, presence: true, uniqueness: { case_sensitive: false }

 before_save :lower_case_fields

 private
   def lower_case_fields
     self.name.downcase!
   end
end
