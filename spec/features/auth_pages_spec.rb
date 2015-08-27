require 'rails_helper'

describe 'Authentication' do
  subject { page }

  describe 'signin page' do
    before { visit new_company_session_path }

    it { should have_content('LOG IN') }
  end

  describe 'signin' do
    before { visit new_company_session_path }

    describe 'with invalid information' do
      before { find('.btn.teal').click }

      it { should have_selector('div>p.alert') }
    end

    describe 'with valid information and no payment redirect to payment page' do
      let(:company) { FactoryGirl.create(:company) }
      before do
        fill_in 'Email',    with: company.email
        fill_in 'Password', with: company.password
        find('.btn.teal').click
      end

      it { should have_content('PRICING') }
      it { should have_content('This is a paid service, canceled a monthly basis.') }
      it { should have_selector('#customButton') }
    end

    describe 'with valid information and payment' do
      let(:company) { FactoryGirl.create(:company_complete_with_payment) }
      before do
        fill_in 'Email',    with: company.email
        fill_in 'Password', with: company.password
        find('.btn.teal').click
      end

      it { should have_content('Edit Profile Information') }
      it { should have_content(company.name) }
    end

    describe 'with approve account and payments redirect to dashboard' do
      let(:company) { FactoryGirl.create(:company_approve_with_payment) }
      before do
        fill_in 'Email',    with: company.email
        fill_in 'Password', with: company.password
        find('.btn.teal').click
      end

      it { should have_content('ALL TEAMS') }
    end
  end
end