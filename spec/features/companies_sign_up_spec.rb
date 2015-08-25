require 'rails_helper'

describe 'Sign Up Company' do
  subject { page }

  describe 'Go to select type company' do 
    before do 
      visit root_path 
      find('#start-now').click
    end
    it { expect(page).to have_content('WHAT ARE YOU LOOKING FOR?') }

    describe 'select normal company' do
      let(:company) { build(:company) }
      before { find('#company').click }
      it { expect(page).to have_content('CREATE AN ACCOUNT') }

      describe 'create acount as normal company' do
        before do 
          sign_up_with company
        end
        it { expect(page).to have_content('PRICING') }
        it { expect(page).to have_selector('#customButton') }
      end
    end

    describe 'select team company' do 
      let(:company) { build(:company) }
      before { find('#team_company').click }
      it { expect(page).to have_selector('#company_team_skill_ids') }

      describe 'create acount as normal company' do
        before do 
          sign_up_with company
        end
        it { expect(page).to have_content('PRICING') }
        it { expect(page).to have_selector('#customButton') }
      end
    end
  end
end