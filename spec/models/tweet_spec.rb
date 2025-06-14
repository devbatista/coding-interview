require 'rails_helper'

RSpec.describe Tweet, type: :model do
  let!(:company) { Company.create!(name: "Empresa Teste") }

  let!(:user1) { User.create!(username: "user1", company: company) }
  let!(:user2) { User.create!(username: "user2", company: company) }

  let!(:tweet1) { Tweet.create!(user: user1, body: "First tweet", created_at: 2.days.ago) }
  let!(:tweet2) { Tweet.create!(user: user1, body: "Second tweet", created_at: 1.day.ago) }
  let!(:tweet3) { Tweet.create!(user: user2, body: "Other user", created_at: 3.days.ago) }

  describe ".recent" do
    it "returns tweets from newest to oldest" do
      expect(Tweet.recent).to eq([tweet2, tweet1, tweet3])
    end
  end

  describe ".by_username" do
    it "filtra tweets pelo username do usuário" do
      expect(Tweet.by_username("user1")).to match_array([tweet1, tweet2])
      expect(Tweet.by_username("user2")).to match_array([tweet3])
    end

    it "returns all if username is not provided" do
      expect(Tweet.by_username(nil)).to match_array([tweet1, tweet2, tweet3])
    end
  end

  describe ".before_cursor" do
    it "returns tweets created before the cursor" do
      cursor = tweet2.created_at.to_i
      expect(Tweet.before_cursor(cursor)).to match_array([tweet1, tweet3])
    end

    it "returns all if cursor is not given" do
      expect(Tweet.before_cursor(nil)).to match_array([tweet1, tweet2, tweet3])
    end
  end

  describe ".paginate" do
    it "limits the amount of tweets" do
      expect(Tweet.paginate(2).size).to eq(2)
    end
  end
end