# == Schema Information
#
# Table name: securities
#
#  id          :integer          not null, primary key
#  symbol      :string(255)      not null
#  name        :string(255)      not null
#  exchange_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#  active      :boolean          default(TRUE), not null
#  sector_id   :integer          not null
#

class Security < ActiveRecord::Base
  include InsensitiveUniqueField
  
  belongs_to :exchange
  belongs_to :sector
  has_one :industry, through: :sector

  scope :active, -> { where active: true }
  scope :inactive, -> { where active: false }

  validates :exchange_id, presence: true
  validates :sector_id, presence: true
  validates :industry, presence: true

  validates :name, presence: true
  validates :active, :inclusion => { :in => [true, false] }

  insensitive_unique :symbol, uniqueness: { scope: :exchange_id, 
                                            case_sensitive: false,
                                            message: "Security symbol should be unique per exchange" }

  def symbol=(symbol)
    write_attribute(:symbol, symbol.nil? ? symbol : symbol.downcase)
  end

  def qualified_name
    "#{exchange.name.upcase}:#{symbol.upcase}"
  end

  def to_s
    "#{id} - #{symbol} - #{name}"
  end
end
