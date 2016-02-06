module MutantSchoolAPIModel
  class Resource

    # Default attribute list
    def self.base_attribute_names
      [
        :id,
        :created_at,
        :updated_at,
        :url
      ]
    end

    def self.model_specific_attribute_names
      []
    end

    def self.attribute_names
      self.base_attribute_names.map(&:to_sym) + self.model_specific_attribute_names.map(&:to_sym)
    end

    def self.setter_attribute_names
      attribute_names.map{|name| "#{name}=".to_sym }
    end

    attr_accessor :response
    attr_reader :errors

    # Hash of nested resources, e.g. `{ attribute_name: ResourceClassName }`
    def self.includes
      {}
    end

    # Attributes that must not be included in POST/PUT payloads.
    def self.disallowed_params
      self.attribute_names + self.includes.keys
    end

    def self.base_url
      'https://mutant-school.herokuapp.com/api/v1'
    end

    def self.url(parent = nil)
      base = (parent && parent.url || self.base_url)
      base + "/#{self.name.split('::').last.downcase}s"
    end

    def self.all(options = {})
      options.stringify_keys!
      response = HTTP.get(self.url(options['parent']))
      return [] if response.code != 200
      JSON.parse(response.to_s).map do |attr|
        self.new attr
      end
    end

    def self.find(id, options = {})
      options.stringify_keys!
      response = HTTP.get(self.url(options['parent']) + "/#{id}")
      return JSON.parse(response.to_s) if response.code != 200

      if (JSON.parse(response).class == Array)
        JSON.parse(response).map{|c| self.new(c) }
      else
        self.new response
      end
    end

    def initialize(attributes_or_response = nil)
      @url = self.class.url
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

    def symbolize_keys(hash)
      hash.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
    end

    def update_attributes(attrs)
      symbolize_keys(attrs).slice(*self.class.attribute_names).each do |name, value|
        if self.class.includes.keys.include? name
          value = self.class.includes[name].new value
        end
        instance_variable_set("@#{name}", value)
      end
    end

    def save
      @errors = []
      if persisted?
        @response = HTTP.put(@url, json: params)
        return reload
      else
        @response = HTTP.post(@url, json: params)
        return reload
      end
    end

    def destroy
      return false unless persisted?
      @response = HTTP.delete(@url)
      add_errors and return false if @response.code != 204
      @id = nil
      @created_at = nil
      @updated_at = nil
      @url = self.class.url
      true
    end

    def attributes
      attribute_collection = {}
      self.class.attribute_names.each do |attribute_name|
        attribute_collection[attribute_name] = send(attribute_name)
      end
      attribute_collection
    end

    def persisted?
      !!@id
    end

    def method_missing(method_sym, *arguments, &block)
      # the first argument is a Symbol, so you need to_s it if you want to pattern match
      if self.class.attribute_names.include?(method_sym)
        instance_variable_get("@#{method_sym}")
      elsif self.class.setter_attribute_names.include?(method_sym)
        equalless_name = method_sym.to_s[0..(method_sym.to_s.index('=') - 1)]
        instance_variable_set("@#{equalless_name}", arguments.first)
      else
        super
      end
    end

    def to_hash
      attributes.except(*self.class.disallowed_params)
    end

    def params
      { self.class.name.split('::').last.downcase => attributes }
    end

    private


      def add_errors
        @errors << JSON.parse(@response.to_s)
      end
  end
end
