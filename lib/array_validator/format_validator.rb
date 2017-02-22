class ArrayValidator < ActiveModel::EachValidator
  module FormatValidator
    def self.call(record, attribute, values, options = {})
      return if options[:format].nil?
      invalid_values = values.select { |value| value !~ options[:format] }
      return if invalid_values.empty?

      record.errors[attribute].push(
        I18n.t('format', scope: I18N_SCOPE, invalid_values: invalid_values.join(', '))
      )
    end
  end
end
