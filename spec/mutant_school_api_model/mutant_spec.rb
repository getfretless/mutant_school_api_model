require 'test_helper'

describe MutantSchoolAPIModel::Mutant, '#attrbutes' do

  it 'should have all of the attributes' do
    wolverine = MutantFactory.build
    assert(wolverine.attributes, { mutant_name: 'Wolverine',
      power: 'Healing',
      real_name: 'James "Logan" Howlett',
      eligibility_begins_at: '1974-10-01',
      eligibility_ends_at: '',
      may_advise_beginning_at: '1974-10-01',
      advisor: 'Professor Xavier'
    })
  end

  it 'should update the attributes' do
    wolverine = MutantFactory.build
    wolverine.update_attributes({ 'id' => 9999})
    _(wolverine.id).must_equal(9999)
  end

end


describe MutantSchoolAPIModel::Mutant, 'missing method attributes' do

  it 'should set the base class attribute' do
    wolverine = MutantFactory.build
    wolverine.id = 9999
    _(wolverine.id).must_equal(9999)
  end

  it 'should set the base class attribute' do
    wolverine = MutantFactory.build
    wolverine.mutant_name = 'AR3'
    _(wolverine.mutant_name).must_equal('AR3')
  end
end

describe MutantSchoolAPIModel::Mutant, '#save' do

  it 'should receive true when trying to save a new mutant' do
    wolverine = MutantFactory.build
    _(wolverine.save).wont_equal(false)
  end

  it 'should have mutant id set after saving a new mutant' do
    wolverine = MutantFactory.build
    wolverine.save
    _(wolverine.id).wont_be_nil
  end

end

describe MutantSchoolAPIModel::Mutant, '#find' do

  it 'should retrieve the mutant that was just created' do
    wolverine = MutantFactory.build
    wolverine.save

    _(MutantSchoolAPIModel::Mutant.find(wolverine.id).attributes).must_equal(wolverine.attributes)
  end

end
