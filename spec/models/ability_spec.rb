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
  let(:user) { FactoryGirl.create(:user) }

  it_behaves_like "read-only ability", Exchange.new
  it_behaves_like "read-only ability", Security.new

  it "should have the ability to CRUD (him|her)self" do
    expect(user).to have_ability([:read, :create, :destroy, :update], for: user)
  end

  it "should not have the ability to CRUD someone else" do
    no_ability = { read: false, create: false, destroy: false, update: false };
    expect(user).to have_ability(no_ability, for: FactoryGirl.create(:user))
  end

  it "should have the ability to CRUD its own portfolio" do
    expect(user).to have_ability([:read, :create, :destroy, :update], for: user.portfolios.sample)
  end

  it "should have no ability on someone else's portfolios" do
    no_ability = { read: false, create: false, destroy: false, update: false };
    expect(user).to have_ability(no_ability, for: FactoryGirl.create(:user).portfolios.sample)
  end

end