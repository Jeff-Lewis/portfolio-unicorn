# == Schema Information
#
# Table name: portfolios
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Portfolio < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
end