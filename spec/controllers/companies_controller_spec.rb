require 'rails_helper'

describe CompaniesController do
  company_login

  it "has a current_user logged in" do
    expect(subject.current_company).not_to be_nil
  end

  describe "GET show" do
    let(:company) { create(:company) }

    it "responds with a 200 HTTP status code" do
      get :show, id: company
      expect(response).to have_http_status(:ok)
    end

    it "renders the show template" do
      get :show, id: company
      expect(response).to render_template(:show)
    end
  end

  describe "GET edit" do
    let(:company) { create(:company) }

    it "responds with 200 HTTP status code" do
      get :edit, id: company
      expect(response).to have_http_status(:ok)
    end

    it "renders the edit template" do
      get :edit, id: company
      expect(response).to render_template(:edit)
    end
  end

  describe "PUT/PATCH update" do
    let(:company) { create(:company_with_profile_complete) }

    it "edits the requested company" do
      patch :update, id: company, company: { description: 'new description' }
      expect { company.reload }.to change(company, :description).from(company.description).to('new description')
    end
  end
end