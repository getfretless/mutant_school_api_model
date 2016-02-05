require 'mutant_school_api_model/resource'

module MutantSchoolAPIModel
  class Term < MutantSchoolAPIModel::Resource
    def self.attribute_names
      super + [
        "begins_at",
        "ends_at"
      ]
    end

    def enrollments
      @enrollments ||= Enrollment.all(parent: self)
    end
  end
end
