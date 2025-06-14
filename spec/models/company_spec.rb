require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "validations" do
    it "is invalid without name" do
      company = Company.new(name: nil)
      expect(company).not_to be_valid
      expect(company.errors[:name]).to(include("can't be blank"))
    end

    it "is invalid with duplicate name" do
      Company.create!(name: "Company X")
      company2 = Company.new(name: "Company X")
      expect(company2).not_to be_valid
      expect(company2.errors[:name]).to(include("has already been taken"))
    end

    it "is valid with unique name" do
      company = Company.new(name: "Company Y")
      expect(company).to(be_valid)
    end
  end

  describe "associations" do
    it "can have many users" do
      company = Company.create!(name: "Company Z")
      user1 = User.create!(username: "user1", company: company)
      user2 = User.create!(username: "user2", company: company)
      expect(company.users).to(include(user1, user2))
    end
  end
end