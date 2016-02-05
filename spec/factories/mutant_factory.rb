class MutantFactory
  def self.build
    mutant = MutantSchoolAPIModel::Mutant.new
    mutant.mutant_name = 'Wolverine'
    mutant.power = 'Healing'
    mutant.real_name = 'James "Logan" Howlett'
    mutant.eligibility_begins_at = '1974-10-01'
    mutant.eligibility_ends_at = ''
    mutant.may_advise_beginning_at = '1974-10-01'
    mutant.advisor = 'Professor Xavier'
    mutant
  end
end
