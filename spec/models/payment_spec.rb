require 'rails_helper'

describe Payment do
  it 'is valid with correct date' do
    expect(build(:payment)).to be_valid
  end

  it 'is invalid with incorrect date' do
    expect(build(:payment_expired).time_expired?).to eq(true)
  end

end