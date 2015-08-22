require 'rails_helper'

describe 'Authentication' do
  subject { page }

  describe 'signin page' do
    before { visit new_company_session_path }

    it { should have_content('Log in') }
  end

  describe 'signin' do
    before { visit new_company_session_path }

    describe 'with invalid information' do
      before { click_button 'Login!' }

      it { should have_selector('div>p.alert') }
    end

    describe 'with valid information and no payment redirect to payment page' do
      let(:company) { FactoryGirl.create(:company) }
      before do
        fill_in 'Email',    with: company.email
        fill_in 'Password', with: company.password
        click_button 'Login!'
      end

      it { should have_content('PRICING') }
      it { should have_content('This is a paid service, canceled a monthly basis.') }
      it { should have_selector('#customButton') }
    end
  end
end