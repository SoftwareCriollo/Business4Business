require 'rails_helper'

describe Company do
  it 'is valid with all fields' do
    expect(build(:company)).to be_valid
  end

  it 'is invalid without type company' do
    expect(build(:company, type:nil)).not_to be_valid
  end

  it 'with the profile complete' do
    expect(build(:company_with_profile_complete).complete_profile?).to eq(true)
  end

  it 'with fee paid' do
    expect(build(:company_with_payments).fee_paid?).to eq(true)
  end
end