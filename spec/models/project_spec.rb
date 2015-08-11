require 'rails_helper'

describe Project do

  it 'is valid with required field' do
    expect(build(:project)).to be_valid
  end

  it 'is invalid without required field' do
    expect(build(:project_invalid)).not_to be_valid
  end

end