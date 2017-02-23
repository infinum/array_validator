class ArrayValidator < ActiveModel::EachValidator
  module DuplicatesValidator
    def self.call(record, attribute, values, options = {})
      return if options[:duplicates] != false
      duplicates = values.select { |value| values.count(value) > 1 }.uniq
      return if duplicates.none?

      record.errors[attribute].push(
        I18n.t('duplicates', scope: I18N_SCOPE, invalid_values: duplicates.join(', '))
      )
    end
  end
end
