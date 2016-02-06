class MutantFactory

  def self.build(mutant_name=:wolverine)
    mutant = MutantSchoolAPIModel::Mutant.new
    attrs = MUTANT_ATTRIBUTES[mutant_name] || MUTANT_ATTRIBUTES[:wolverine]
    mutant.update_attributes(attrs)
    mutant
  end

  MUTANT_ATTRIBUTES = {
    wolverine: {
      mutant_name: 'Wolverine',
      power: 'Healing',
      real_name: 'James "Logan" Howlett',
      eligibility_begins_at: '1974-10-01',
      eligibility_ends_at: '',
      may_advise_beginning_at: '1974-10-01'
    },
    xavier: {
      mutant_name: 'Professor X',
      power: 'Telepathy',
      real_name: 'Charles Francis Xavier',
      eligibility_begins_at: '1963-09-01',
      eligibility_ends_at: '',
      may_advise_beginning_at: '1963-09-01'
    }
  }

end
