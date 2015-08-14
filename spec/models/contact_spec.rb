require 'rails_helper'

describe Contact do
  it 'is valid with all fields' do
    expect(build(:contact)).to be_valid
  end

  it 'is invalid without email field' do
    expect(build(:contact, email: nil)).not_to be_valid
  end
end