require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:company_1) { create(:company) }
  let!(:company_2) { create(:company) }
  let!(:users_company_1) { create_list(:user, 5, company: company_1) }
  let!(:users_company_2) { create_list(:user, 5, company: company_2) }

  describe "GET #index" do
    context "when searching for users by company" do
      it "assigns only users from the specified company to @users" do
        get :index, params: { company_identifier: company_1.id }
        expect(assigns(:users)).to match_array(users_company_1)
      end
    end

    context "when searching for all users" do
      it "assigns all users to @users" do
        get :index
        expect(assigns(:users)).to match_array(User.all)
      end
    end

    context "when searching by username" do
      it "assigns only users with the searched username to @users" do
        user = users_company_1.first
        get :index, params: { username: user.username }
        expect(assigns(:users)).to match_array([user])
      end
    end
  end
end