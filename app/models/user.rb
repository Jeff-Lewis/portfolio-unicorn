# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)      not null
#

class User < ActiveRecord::Base
  before_save :ensure_authentication_token

  has_many :portfolios

  # Include default devise modules. Others available are:
  # :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  validates :username, presence: true, 
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 2 }
  
  after_create :create_default_portfolio

  private
    def create_default_portfolio
      self.portfolios.create(name: 'Master Portfolio')
    end
end
