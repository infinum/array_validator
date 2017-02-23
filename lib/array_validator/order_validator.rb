class ArrayValidator
  module OrderValidator
    def self.call(record, attribute, values, options)
      return if options[:order].nil?
      raise ArgumentError, 'Not a supported order option' unless [:asc, :desc].include?(options[:order])

      ordered = if options[:order] == :asc
                  values.sort == values
                else
                  values.sort.reverse == values
                end
      return if ordered

      record.errors[attribute] << I18n.t(
        'sorting', scope: ArrayValidator::I18N_SCOPE, direction: "#{options[:order]}ending"
      )
    end
  end
end
