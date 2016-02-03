require 'test_helper'

describe MutantSchoolApiModel do
  it 'has a version number' do
    _(::MutantSchoolApiModel::VERSION).wont_be_nil
  end

  it 'does something useful' do
    _(false).must_be_same_as true
  end
end
