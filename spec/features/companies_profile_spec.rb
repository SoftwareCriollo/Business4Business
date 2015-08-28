require 'rails_helper'
require 'faker'

describe 'Company Profile' do
  subject { page }

  describe 'Go to complete profile page' do
    let!(:company) { create(:company_complete_with_payment) }
    before do
      sign_in company
      visit edit_company_path(company)
    end

    it { expect(page).to have_content(company.name) }
    it { expect(page).to have_content('Complete your Profile') }

    describe 'sent complete form' do
      before do
        fill_in 'Website', with: Faker::Internet.url 
        fill_in 'Description', with: Faker::Lorem.paragraph
        fill_in 'company_contact_name', with: Faker::Lorem.word
        fill_in 'company_team_members', with: Faker::Number.number(2)
        fill_in 'company_tax_id', with: Faker::Number.number(10)
        fill_in 'Address', with: Faker::Address.street_address
        find('.btn-company-profile-submit').click
      end

      it { expect(page).to have_no_selector('.contact-button') }
      it { expect(page).to have_content('EDIT COMPANY') }
    end

    describe 'try go to normal company dashboard without permissons' do
      before do
        visit company_dashboard_path
      end
      it { expect(page).to have_content('You are not authorized to access this page.') }
      it { expect(page).to have_content('HIRE TEAMS') }
    end
  end

  describe 'try go to normal company dashboard with permissons' do
    let(:company) { create(:company_approve_with_payment) }
    before do
      sign_in company
      visit company_dashboard_path
    end
    it { expect(page).to have_content('ALL TEAMS') }
  end

  describe 'try go to team company dashboard with permissons' do
    let(:team_company) { create(:company_approve_with_payment, type: TypeCompany::TEAM_COMPANY) }
    before do
      sign_in team_company
      visit team_company_dashboard_path
    end
    it { expect(page).to have_content('All Projects') }
  end
end