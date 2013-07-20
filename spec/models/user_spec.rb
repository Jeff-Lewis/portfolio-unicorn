
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

  context "create default portfolio on creation" do
    it "has 1 portfolio" do
      expect(FactoryGirl.create(:user).portfolios.length).to eq(1)
    end

    it "rollbacks BOTH user & portfolio creations if something bad happens" do
      User.any_instance.stub(:create_default_portfolio) { throw :shit_happens }
      expect {
        FactoryGirl.create(:user)
      }.to throw_symbol
      expect(User.count).to eq(0)
      expect(Portfolio.count).to eq(0)
    end
  end
  
end
