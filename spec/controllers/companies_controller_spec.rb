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
    let(:company) { create(:company_complete_with_payment) }
    let(:company_without_pay) { create(:company_with_profile_complete) }

    it "edits the requested company" do
      expect_any_instance_of(Company).to receive(:update).with(description: 'new description').and_return(true)
      put :update, id: company, company: { description: 'new description' }
      expect(response).to redirect_to(company)
    end

    it "edits the requested company fail" do
      expect_any_instance_of(Company).to receive(:update).with(name: nil, description: nil).and_return(false)
      put :update, id: company, company: { name: nil, description: nil }
      expect(response).to render_template("edit")
    end

    it "edits the requested company fail wihout payment" do
      expect_any_instance_of(Company).to receive(:update).with(description: 'new description').and_return(false)
      put :update, id: company_without_pay, company: { description: 'new description' }
      expect(response).to render_template("edit")
    end
  end

  describe "Approve/Decline Company" do
    let(:company) { create(:company_with_profile_complete) }

    it "Approve Company path" do
      get :approve_request, id: company
      expect { company.reload }.to change(company, :status).from(StatusCompany::ON_HOLD.to_s).to(StatusCompany::APPROVE.to_s)
    end

    it "Decline Company path" do
      get :reject_request, id: company
      expect { company.reload }.to change(company, :status).from(StatusCompany::ON_HOLD.to_s).to(StatusCompany::REJECT.to_s)
    end
  end
end
