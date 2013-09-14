# == Schema Information
#
# Table name: exchanges
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

require "spec_helper"

describe Exchange do
  it "has a valid factory" do
    expect(FactoryGirl.create(:exchange)).to be_valid
  end

  it_behaves_like "a case insensitive unique attribute", Exchange, :name
end
