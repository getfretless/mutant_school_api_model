module MutantSchoolAPIModel
  class Mutant
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
    DISALLOWED_PARAMS = [
      "id",
      "created_at",
      "updated_at",
      "url"
    ]

    attr_accessor *ATTRIBUTE_NAMES, :response, :advisor
    attr_reader :errors

    def self.all
      JSON.parse(HTTP.get(BASE_URL + '/mutants').to_s)
    end

    def self.find(id)
      response = HTTP.get(BASE_URL + "/mutants/#{id}")
      return JSON.parse(response.to_s) if response.code != 200
      Mutant.new response
    end

    def initialize(attributes_or_response = nil)
      return unless attributes_or_response
      if attributes_or_response.is_a? HTTP::Response
        @response = attributes_or_response
        reload
      else
        update_attributes(attributes_or_response)
      end
    end

    def reload
      add_errors and return false unless [200, 201].include?(@response.code)
      update_attributes(JSON.parse(@response.to_s))
    end

    def update_attributes(attr)
      attr.stringify_keys!
      init_advisor(attr['advisor'])
      attr.slice(*ATTRIBUTE_NAMES).each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end

    def save
      @errors = []
      if persisted?
        @response = HTTP.put(BASE_URL + "/mutants/#{id}", json: mutant_params)
        return reload
      else
        @response = HTTP.post(BASE_URL + "/mutants", json: mutant_params)
        return reload
      end
    end

    def destroy
      return false unless persisted?
      @response = HTTP.delete(BASE_URL + "/mutants/#{id}")
      add_errors and return false if @response.code != 204
      @id = nil
      true
    end

    def attributes
      attribute_collection = {}
      ATTRIBUTE_NAMES.each do |attribute_name|
        attribute_collection[attribute_name] = send(attribute_name)
      end
      attribute_collection
    end

    def persisted?
      !!@id
    end

    private

    def init_advisor(advisor_hash)
      if advisor_hash
        @advisor = Mutant.new advisor_hash
      end
    end

    def mutant_params
      { mutant: attributes.except(*DISALLOWED_PARAMS) }
    end

    def add_errors
      @errors << JSON.parse(@response.to_s)
    end
  end
end
