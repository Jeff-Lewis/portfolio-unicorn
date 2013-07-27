# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Exchange < ActiveRecord::Base
  include InsensitiveUniqueField

  has_many :securities
  insensitive_unique :name
end
