require 'rails_helper'

describe Project do

  it 'is valid with name field' do
    expect(build(:skill)).to be_valid
  end

  it 'is invalid without name field' do
    expect(build(:skill_invalid)).not_to be_valid
  end

end