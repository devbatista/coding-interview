require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:company_a) { Company.create!(name: "Company A") }
  let!(:company_b) { Company.create!(name: "Company B") }
  let!(:company_c) { Company.create!(name: "Company C") }
  let!(:user1) { User.create!(username: "Robson Fernandes", company: company_a) }
  let!(:user2) { User.create!(username: "Ana Paula", company: company_a) }
  let!(:user3) { User.create!(username: "Junior Santana", company: company_a) }
  let!(:user4) { User.create!(username: "Helena Maria", company: company_b) }
  let!(:user5) { User.create!(username: "Tatiane Dias", company: company_b) }
  let!(:user6) { User.create!(username: "Leandro Velos", company: company_c) }

  describe ".by_company" do
    it "only users from company_a" do
      expect(User.by_company(company_a.id)).to(match_array([user1, user2, user3]))
    end

    it "only users from company_b" do
      expect(User.by_company(company_b.id)).to(match_array([user4, user5]))
    end

    it "only users from company_c" do
      expect(User.by_company(company_c.id)).to(match_array([user6]))
    end

    it "return all users if company_id is null" do
      expect(User.by_company(nil)).to(match_array([user1, user2, user3, user4, user5, user6]))
    end
  end

  describe ".by_username" do
    it "user with partial name and case insensitive" do
      expect(User.by_username('ana')).to(match_array([user2, user3]))
    end

    it "user whit exactly name" do
      expect(User.by_username('Robson Fernandes')).to(eq([user1]))
    end

    it "users with part of the surname" do
      expect(User.by_username('Maria')).to(match_array([user4]))
    end

    it "empty if no match" do
      expect(User.by_username('Rafael')).to(be_empty)
    end
  end
end
