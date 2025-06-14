require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:company_1) { create(:company) }
  let!(:company_2) { create(:company) }
  let!(:users_company_1) { create_list(:user, 5, company: company_1) }
  let!(:users_company_2) { create_list(:user, 5, company: company_2) }

  describe "GET #index" do
    context "quando busca usuários por empresa" do
      it "atribui apenas os usuários da empresa especificada a @users" do
        get :index, params: { company_identifier: company_1.id }
        expect(assigns(:users)).to match_array(users_company_1)
      end
    end

    context "quando busca todos os usuários" do
      it "atribui todos os usuários a @users" do
        get :index
        expect(assigns(:users)).to match_array(User.all)
      end
    end

    context "quando busca por username" do
      it "atribui apenas os usuários com o username buscado a @users" do
        user = users_company_1.first
        get :index, params: { username: user.username }
        expect(assigns(:users)).to match_array([user])
      end
    end
  end
end