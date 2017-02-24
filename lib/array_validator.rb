require 'active_model'
require 'active_support/i18n'
require 'array_validator/subset_validator'
require 'array_validator/format_validator'
require 'array_validator/duplicates_validator'
require 'array_validator/order_validator'

I18n.load_path += Dir[File.dirname(__FILE__) + "/locale/*.yml"]

class ArrayValidator < ActiveModel::EachValidator
  I18N_SCOPE = 'activerecord.errors.messages.array'.freeze
  VALIDATORS = [SubsetValidator, FormatValidator, DuplicatesValidator, OrderValidator].freeze

  def validate_each(record, attribute, values)
    unless values.is_a? Array
      record.errors[attribute] << (options[:message] || 'is not an array')
      return
    end

    VALIDATORS.each do |validator|
      validator.call(record, attribute, values, options)
    end
  end
end
