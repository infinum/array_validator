class ArrayValidator
  module SubsetValidator
    def self.call(record, attribute, values, options)
      return if options[:subset_of].nil?

      unlisted_values = values - options[:subset_of]
      return if unlisted_values.empty?

      error_message = if unlisted_values.size == 1
                        "#{unlisted_values.first} is not in the list"
                      else
                        "#{unlisted_values.join(', ')} are not in the list"
                      end

      record.errors[attribute] << error_message
    end
  end
end
