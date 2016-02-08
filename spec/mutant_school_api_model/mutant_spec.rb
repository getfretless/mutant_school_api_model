require 'test_helper'

describe MutantSchoolAPIModel::Mutant, '#attrbutes' do

  it 'should have all of the attributes' do
    wolverine = MutantFactory.build
    assert(wolverine.attributes, { mutant_name: 'Wolverine',
      power: 'Healing',
      real_name: 'James "Logan" Howlett',
      eligibility_begins_at: '1974-10-01',
      eligibility_ends_at: '',
      may_advise_beginning_at: '1974-10-01'
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

  it 'should set the specific class attribute' do
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

  it 'should update mutant_name' do
    wolverine = MutantFactory.build
    wolverine.save
    wolverine.mutant_name = 'Cyclops'
    wolverine.save

    actual = MutantSchoolAPIModel::Mutant.find(wolverine.id)
    _(actual.mutant_name).must_equal('Cyclops')
  end

end


describe MutantSchoolAPIModel::Mutant, '#find' do

  it 'should retrieve the mutant that was just created' do
    with_fake_http do
      wolverine = MutantFactory.build
      wolverine.save
      
      actual = MutantSchoolAPIModel::Mutant.find(wolverine.id)
      _(actual.attributes).must_equal(wolverine.attributes)
    end
  end

  it 'should should return an empty array when there is no such record' do
    actual = MutantSchoolAPIModel::Mutant.find(nil)
    _(actual).must_be_instance_of(Array)
  end

end

describe MutantSchoolAPIModel::Mutant, '#destroy' do

  it 'should destroy the mutant that was just created' do
    wolverine = MutantFactory.build
    wolverine.save
    id = wolverine.id
    wolverine.destroy
    actual = MutantSchoolAPIModel::Mutant.find(id)
    _(actual).must_equal({"status"=>"404", "error"=>"Not Found"})
  end

end



# describe MutantSchoolAPIModel::Mutant, '#advisor' do

#   xit 'should add an advisor' do
#     prof_x = MutantFactory.build(:xavier)
#     prof_x.save

#     wolverine = MutantFactory.build
#     wolverine.advisor = prof_x.id
#     wolverine.save
#     actual = MutantSchoolAPIModel::Mutant.find(wolverine.id)
# binding.pry
#     _(actual).must_equal({"status"=>"404", "error"=>"Not Found"})
#   end

# end
