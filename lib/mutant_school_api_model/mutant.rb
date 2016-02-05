require 'mutant_school_api_model/resource'

module MutantSchoolAPIModel
  class Mutant < MutantSchoolAPIModel::Resource
    def self.attribute_names
      super + [
        "mutant_name",
        "power",
        "real_name",
        "eligibility_begins_at",
        "eligibility_ends_at",
        "may_advise_beginning_at",
        "advisor"
      ]
    end

    def self.includes
      { "advisor" => Mutant }
    end

    def enrollments
      @enrollments ||= Enrollment.all(parent: self)
    end
  end
end
