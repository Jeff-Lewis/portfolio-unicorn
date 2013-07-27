require 'spec_helper'

shared_examples "read-only ability" do |model|
  let(:user) { FactoryGirl.create(:user) }

  it "should have the ability to read #{model.class.name}" do
    expect(user).to have_ability(:read, for: model)
  end

  it "should not have the ability to manage #{model.class.name}" do
    expect(user).not_to have_ability([:create, :update, :delete], for: model)
  end
end

describe User do
  let(:user) { portfolio.user }
  let(:portfolio) { FactoryGirl.create(:portfolio) }
  let(:no_ability) {{ read: false, create: false, destroy: false, update: false }}

  it_behaves_like "read-only ability", Exchange.new
  it_behaves_like "read-only ability", Security.new

  it "has the ability to CRUD (him|her)self" do
    expect(user).to have_ability([:read, :create, :destroy, :update], for: user)
  end

  it "has the ability to CRUD someone else" do
    expect(user).to have_ability(no_ability, for: FactoryGirl.create(:user))
  end

  context "Portfolio" do
    it "has the ability to CRUD its own portfolio" do
      expect(user).to have_ability([:read, :create, :destroy, :update], for: user.portfolios.sample)
    end

    it "has no ability on someone else's portfolios" do
      expect(user).to have_ability(no_ability, for: FactoryGirl.create(:user).portfolios.sample)
    end
  end

  context "Position" do
    let(:position) { FactoryGirl.create(:position, portfolio: portfolio)}
    it "has the ability to CRUD its own positions" do
      expect(user).to have_ability([:read, :create, :destroy, :update], for: position)
    end

    it "has no ability on someone else's positions" do
      expect(user).to have_ability(no_ability, for: FactoryGirl.create(:position))
    end
  end

end