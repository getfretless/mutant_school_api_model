require 'mutant_school_api_model/resource'

module MutantSchoolAPIModel
  class Mutant < MutantSchoolAPIModel::Resource
    ATTRIBUTE_NAMES = [
      "id",
      "mutant_name",
      "power",
      "real_name",
      "created_at",
      "updated_at",
      "eligibility_begins_at",
      "eligibility_ends_at",
      "may_advise_beginning_at",
      "url",
      "advisor"
    ]

    attr_accessor *ATTRIBUTE_NAMES

    def self.includes
      { "advisor" => Mutant }
    end

    def self.disallowed_params
      super + ["advisor"]
    end
  end
end
