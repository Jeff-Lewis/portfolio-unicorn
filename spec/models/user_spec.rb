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

require 'spec_helper'

describe User do
  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end

  context "email validation" do
    it "is not valid without an email" do
      expect(FactoryGirl.build(:user, email: nil)).not_to be_valid
    end

    it "is not valid with an invalid email address" do
      expect(FactoryGirl.build(:user, email: "illegal.email")).not_to be_valid
    end

    it "is not valid with an email address already taken" do
      FactoryGirl.create(:user, email: "test@example.org")
      expect(FactoryGirl.build(:user, email: "test@example.org")).not_to be_valid
    end
  end

  context "username validation" do
    it "is not valid without a username" do
      expect(FactoryGirl.build(:user, username: nil)).not_to be_valid
    end

    it "is not valid with a username too short" do
      expect(FactoryGirl.build(:user, username: "a")).not_to be_valid
    end

    it "is not valid with a username already taken" do
      FactoryGirl.create(:user, username: 'joe')
      expect(FactoryGirl.build(:user, username: 'joe')).not_to be_valid
    end

    it "is not valid with a username with only different casing" do
      FactoryGirl.create(:user, username: 'joe')
      expect(FactoryGirl.build(:user, username: 'Joe')).not_to be_valid
    end
  end

  it "generates an authentication token when saving" do
    expect(FactoryGirl.create(:user).authentication_token).not_to be_nil
  end
  

end
