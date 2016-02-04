module CoreExtensions
  module Hash
    # Slice a hash to include only the given keys. Returns a hash containing the given keys.
    def slice(*keys)
      keys.map! { |key| convert_key(key) } if respond_to?(:convert_key, true)
      keys.each_with_object(self.class.new) { |k, hash| hash[k] = self[k] if has_key?(k) }
    end

    # Returns a hash that includes everything but the given keys.
    def except(*keys)
      dup.except!(*keys)
    end

    # Replaces the hash without the given keys.
    def except!(*keys)
      keys.each { |key| delete(key) }
      self
    end

    # Returns a new hash with all keys converted to strings.
    def stringify_keys
      transform_keys{ |key| key.to_s }
    end

    # Destructively convert all keys to strings. Same as stringify_keys, but modifies self.
    def stringify_keys!
      transform_keys!{ |key| key.to_s }
    end

    # Returns a new hash with all keys converted using the block operation.
    def transform_keys
      return enum_for(:transform_keys) unless block_given?
      result = self.class.new
      each_key do |key|
        result[yield(key)] = self[key]
      end
      result
    end

    # Destructively convert all keys using the block operations. Same as #transform_keys but modifies self.
    def transform_keys!
      return enum_for(:transform_keys!) unless block_given?
      keys.each do |key|
        self[yield(key)] = delete(key)
      end
      self
    end
  end
end

Hash.send(:include, CoreExtensions::Hash) unless Hash.method_defined? :slice
