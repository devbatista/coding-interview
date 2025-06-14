require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  let!(:user1) { create(:user, username: "user1") }
  let!(:user2) { create(:user, username: "user2") }
  let!(:tweet1) { create(:tweet, user: user1, created_at: 3.days.ago) }
  let!(:tweet2) { create(:tweet, user: user1, created_at: 2.days.ago) }
  let!(:tweet3) { create(:tweet, user: user2, created_at: 1.day.ago) }

  describe "GET #index" do
    it "assigns the most recent tweets to @tweets" do
      get :index
      expect(assigns(:tweets)).to(eq([tweet3, tweet2, tweet1]))
    end

    it "filter tweets by username" do
      get :index, params: { user_username: "user1" }
      expect(assigns(:tweets)).to(match_array([tweet2, tweet1]))
    end

    it "paginates tweets" do
      get :index, params: { per_page: 2 }
      expect(assigns(:tweets).size).to(eq(2))
    end

    it "filter tweets by cursor" do
      cursor = tweet3.created_at.to_i
      get :index, params: { cursor: cursor }
      expect(assigns(:tweets)).(match_array([tweet2, tweet1]))
    end

    it "assigns the next cursor to @next_cursor" do
      get :index, params: { per_page: 2 }
      expect(assigns(:next_cursor)).(eq(assigns(:tweets).last.created_at.to_i))
    end
  end
end