require 'mutant_school_api_model/resource'

module MutantSchoolAPIModel
  class Enrollment < MutantSchoolAPIModel::Resource
    def self.attribute_names
      super + [
        "student",
        "student_id",
        "term",
        "term_id"
      ]
    end

    def self.includes
      {
        "student" => Mutant,
        "term" => Term
      }
    end
  end
end
