# == Schema Information
#
# Table name: industries
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Industry < ActiveRecord::Base
  include InsensitiveUniqueField
  has_many :industries

  insensitive_unique :name
end
