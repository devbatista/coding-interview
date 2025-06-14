require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let!(:company) { create(:company, name: "Test Company") }

  describe "GET #index" do
    it "assigns all companies to @companies" do
      get :index
      expect(assigns(:companies)).to(include(company))
    end
  end

  describe "GET #show" do
    it "assigns the requested company to @company" do
      get :show, params: { id: company.id }
      expect(assigns(:company)).to(eq(company))
    end
  end

  describe "GET #new" do
    it "assigns a new company to @company" do
      get :new
      expect(assigns(:company)).to(be_a_new(Company))
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new company and redirects" do
        expect {
          post :create, params: { company: { name: "Another Company" } }
        }.to(change(Company, :count).by(1))
        expect(response).to(redirect_to(Company.last))
      end
    end

    context "with invalid params" do
      it "does not create a company and renders new" do
        expect {
          post :create, params: { company: { name: "" } }
        }.not_to change(Company, :count)
        expect(response).to(render_template(:new))
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested company to @company" do
      get :edit, params: { id: company.id }
      expect(assigns(:company)).to(eq(company))
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "updates the company and redirects" do
        patch :update, params: { id: company.id, company: { name: "Updated Name" } }
        expect(company.reload.name).to(eq("Updated Name"))
        expect(response).to(redirect_to(company))
      end
    end

    context "with invalid params" do
      it "does not update the company and renders edit" do
        patch :update, params: { id: company.id, company: { name: "" } }
        expect(company.reload.name).to(eq("Test Company"))
        expect(response).to(render_template(:edit))
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the company and redirects to index" do
      expect {
        delete :destroy, params: { id: company.id }
      }.to(change(Company, :count).by(-1))
      expect(response).to(redirect_to(companies_path))
    end
  end
end