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
  

end
