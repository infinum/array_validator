class ArrayValidator < ActiveModel::EachValidator
  module SubsetValidator
    def self.call(record, attribute, values, options = {})
      return if options[:subset_of].nil?
      unlisted_values = values - options[:subset_of]
      return if unlisted_values.none?

      record.errors[attribute].push(
        I18n.t('subset_of', scope: I18N_SCOPE, invalid_values: unlisted_values.join(', '))
      )
    end
  end
end
