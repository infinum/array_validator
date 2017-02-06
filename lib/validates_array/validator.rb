module ValidatesArray
  class Validator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value.is_a? Array
        record.errors[attribute] << (options[:message] || 'is not an array')
        return
      end

      if options[:subset_of].present?
        check_subset(record, attribute, value)
      end
    end

    private

    def check_subset(record, attribute, value)
      unlisted_values = value - options[:subset_of]
      return if unlisted_values.empty?

      record.errors[attribute] << subset_error_message(unlisted_values)
    end

    def subset_error_message(unlisted_values)
      if unlisted_values.size == 1
        "#{unlisted_values.first} is not in the list"
      else
        "#{unlisted_values.join(', ')} are not in the list"
      end
    end
  end
end
