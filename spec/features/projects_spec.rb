require 'rails_helper'
require 'faker'

describe 'Projects Features' do
  subject { page }

  describe 'Visit a new project page' do
    let(:company){ create(:company_approve_with_payment) }
    before do
      @company = company
      sign_in company
      visit new_project_path
    end

    it { expect(page).to have_content('New Project') }

    describe 'After create a new project' do
      let!(:project){ create(:project) }
      before do
        fill_in 'Name', with: project.name
        fill_in 'Timeframe', with: project.timeframes
        fill_in 'Budget', with: Faker::Number.number(3)
        fill_in 'Description', with: project.description
        find('.btn-large').click
      end
      it 'Page has edit project link' do 
        expect(page).to have_content('EDIT PROJECT') 
      end
      it 'Page has name of project' do
       expect(page).to have_content(project.name.capitalize)
      end
    end

    describe 'after edit own project' do
      let!(:project){ create(:project, company: @company) }
      before do 
        visit edit_project_path(project)
        fill_in 'Name', with: 'New name'
        find('.btn-large').click
      end
      it 'Page has edited name of project' do
        expect(page).to have_content('New name')
      end 
      it 'Page has success message of edit' do
        expect(page).to have_content('Edit project sucessfully')
      end
    end

    describe 'trying to edit someone else`s project' do
      let!(:project){ create(:project) }
      before do 
        visit edit_project_path(project)
      end
      it 'The page has not having permits message' do
        expect(page).to have_content('Not allowed to update this project')
      end 

      it 'Redirect to home page' do
        expect(current_path).to eq(root_path)
      end
    end 
  end

  describe 'Visit team user dashboard page (All projects)' do
    let!(:project){ create(:project) }
    let(:company){ create(:company_approve_with_payment, type: TypeCompany::TEAM_COMPANY) }
    before do
      sign_in company
      visit team_company_dashboard_path
    end

    it 'Page has one project' do
      expect(page).to have_content(project.name)
    end

    it 'Page has title All Projects' do
      expect(page).to have_content('All Projects')
    end

  end 
end