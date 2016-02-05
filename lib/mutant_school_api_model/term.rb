require 'mutant_school_api_model/resource'

module MutantSchoolAPIModel
  class Term < MutantSchoolAPIModel::Resource
    ATTRIBUTE_NAMES = [
      "id",
      "begins_at",
      "ends_at"
    ]

    attr_accessor *ATTRIBUTE_NAMES
  end
end
