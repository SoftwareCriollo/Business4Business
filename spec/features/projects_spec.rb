require 'rails_helper'
require 'faker'

describe 'Projects Features' do
  subject { page }

  describe 'Visit a new project page' do
    let(:company){ create(:company_approve_with_payment) }
    before do
      sign_in company
      visit new_project_path
    end

    it { expect(page).to have_content('New Project') }
  end
end