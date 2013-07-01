# == Schema Information
#
# Table name: securities
#
#  id          :integer          not null, primary key
#  symbol      :string(255)      not null
#  name        :string(255)      not null
#  exchange_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Security < ActiveRecord::Base
  belongs_to :exchange

  validates :exchange_id, presence: true
  validates :symbol, presence: true,
                      uniqueness: { scope: :exchange_id, 
                                    case_sensitive: false,
                                    message: "Security symbol should be unique per exchange" }
  validates :name, presence: true

  before_save :lower_case_fields

  def symbol=(symbol)
    write_attribute(:symbol, symbol.nil? ? symbol : symbol.downcase)
  end

  private
    def lower_case_fields
      self.symbol.downcase!
    end
end