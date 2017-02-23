class ArrayValidator
  module SortValidator
    def self.call(record, attribute, values, options)
      return if options[:sorted].nil?
      raise ArgumentError, 'Not a supported sorting option' unless [:asc, :desc].include?(options[:sorted])

      sorted = if options[:sorted] == :asc
                 values.sort == values
               else
                 values.sort.reverse == values
               end
      return if sorted

      record.errors[attribute] << I18n.t(
        'sorting', scope: ArrayValidator::I18N_SCOPE, direction: "#{options[:sorted]}ending"
      )
    end
  end
end
