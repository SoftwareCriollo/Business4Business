require 'rails_helper'

describe CompaniesController do
  company_login

  it "has a current_user logged in" do
    expect(subject.current_company).not_to be_nil
  end

  describe "GET index" do

    describe "without permissions" do
      before { get :index }
      it "responds with a 302 HTTP status code" do
        expect(response).to have_http_status(302)
      end

      it "redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end

      it "show unauthorised message" do
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end
  end

  describe "GET new" do
    it "responds with a 200 HTTP status code" do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET Type Company" do
    it "responds with a 200 HTTP status code" do
      get :type_company
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST create" do
    let(:company) { FactoryGirl.build(:company).attributes }
    let(:company_fail) { FactoryGirl.build(:company, email:'').attributes }

    it "responds with 200 HTTP status code" do
      post :create, company: company
      expect(response).to have_http_status(:ok)
    end

    it "renders the new template" do
      post :create, company: company
      expect(response).to render_template(:new)
    end
  end

  describe "GET edit" do
    describe " with permissions (owner information) " do
      let(:company) { subject.current_company }
      it "responds with 200 HTTP status code" do
        get :edit, id: company
        expect(response).to have_http_status(:ok)
      end

      it "renders the edit template" do
        get :edit, id: company
        expect(response).to render_template(:edit)
      end
    end

    describe "without permissions" do
      let(:company) { create(:company) }
      before { get :edit, id: company }

      it "responds with 302 HTTP status code" do
        expect(response).to have_http_status(302)
      end

      it "redirect to root_path" do
        expect(response).to redirect_to(root_path)
      end

      it "show unauthorised message" do
        expect(flash[:alert]).to eq('You are not authorized to access this page.')
      end
    end

  end

end
