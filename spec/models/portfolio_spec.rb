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

require 'spec_helper'

describe Portfolio do

  it "is not valid without a user" do
    expect(FactoryGirl.build(:portfolio, user: nil)).not_to be_valid
  end

end
