require 'mutant_school_api_model/resource'

module MutantSchoolAPIModel
  class Term < MutantSchoolAPIModel::Resource
    def self.attribute_names
      super + [
        "id",
        "begins_at",
        "ends_at",
        "created_at",
        "updated_at",
        "url"
      ]
    end

    def enrollments
      @enrollments ||= Enrollment.all(parent: self)
    end
  end
end
