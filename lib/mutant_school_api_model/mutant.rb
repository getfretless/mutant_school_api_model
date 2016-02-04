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
      "url"
    ]

    attr_accessor *ATTRIBUTE_NAMES, :response, :advisor
    attr_reader :errors

    def self.attribute_names
      ATTRIBUTE_NAMES
    end

    def self.disallowed_params
      [
        "id",
        "created_at",
        "updated_at",
        "url"
      ]
    end

    def update_attributes(attr)
      attr.stringify_keys!
      init_advisor(attr['advisor'])
      attr.slice(*ATTRIBUTE_NAMES).each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end

    private

    def init_advisor(advisor_hash)
      if advisor_hash
        @advisor = Mutant.new advisor_hash
      end
    end
  end
end
