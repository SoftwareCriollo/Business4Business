require 'rails_helper'
require "cancan/matchers"

describe "Company" do
  describe "abilities" do
    subject(:ability){ Ability.new(company) }
    let(:company){ nil }

    context "When is normal company" do
      let(:company){ create(:company) }

      it 'Can manage only own information' do
       should be_able_to(:manage, Company.new(id: company.id)) 
      end
      it 'Can manage only own projects' do
       should be_able_to(:manage, Project.new(company_id: company.id))
      end
      it 'Can not destroy or edit other proyects' do 
        expect(ability.can?([:edit, :destroy], Project.new)).to eq(false) 
      end
      it 'Can view others profile' do
        expect(ability.can?(:show, Company.new)).to eq(true) 
      end
      it 'Can not view team_company_dashboard' do
        expect(ability.can?(:index, Project.new)).to eq(false)
      end
      it 'Can not view company dashboard without payment, complete profile and approve status' do
        expect(ability.can?(:index, Company.new)).to eq(false)
      end
    end

    context "When is team company" do
      let(:company){ create(:team_company) }

      it 'Can manage only own information' do
       should be_able_to(:manage, Company.new(id: company.id)) 
      end
      it 'Can not manage projects' do
        expect(ability.can?(:manage, Project.new)).to eq(false)
      end
      it 'Can view others profile' do
        expect(ability.can?(:show, Company.new)).to eq(true) 
      end
      it 'Can not view company_dashboard' do
        expect(ability.can?(:index, Company.new)).to eq(false)
      end
      it 'Can not view projects dashboard without payment, complete profile and approve status' do
        expect(ability.can?(:index, Company.new)).to eq(false)
      end
      it 'Can not view full info of projects without approve status' do
        expect(ability.can?(:show, Project.new)).to eq(false)
      end
    end

    context 'When is guest company' do
      let(:company){ create(:company, type: 'Guest') }
      it 'Can not manage projects' do
        expect(ability.can?(:manage, Project.new)).to eq(false)
      end
      it 'Can not manage companies' do
        expect(ability.can?(:manage, Company.new)).to eq(false)
      end
      it 'Can not view companies dashboard' do
        expect(ability.can?(:index, Company.new)).to eq(false)
      end
      it 'Can not view projects dashboard' do
        expect(ability.can?(:index, Project.new)).to eq(false)
      end
      it 'Can not view others profile' do
        expect(ability.can?(:show, Company.new)).to eq(false) 
      end
      it 'Can create new account' do
        expect(ability.can?(:create, Company.new)).to eq(true) 
      end
    end
  end
end