require 'active_model'
require 'active_support/i18n'

class ArrayValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    unless values.is_a? Array
      record.errors[attribute] << (options[:message] || 'is not an array')
      return
    end

    if options[:subset_of].present?
      check_subset(record, attribute, values)
    end

    if options[:format].present?
      check_format(record, attribute, values)
    end

    if options[:duplicates] == false
      check_duplicates(record, attribute, values)
    end
  end

  private

  def check_subset(record, attribute, values)
    unlisted_values = values - options[:subset_of]
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

  def check_format(record, attribute, values)
    invalid_values = values.select { |value| value !~ options[:format] }
    return if invalid_values.empty?

    record.errors[attribute] << format_error_message(invalid_values)
  end

  def format_error_message(invalid_values)
    if invalid_values.size == 1
      "#{invalid_values.first} is not in a valid format"
    else
      "#{invalid_values.join(', ')} are not in a valid format"
    end
  end

  def check_duplicates(record, attribute, values)
    duplicates = values.select { |value| values.count(value) > 1 }.uniq
    return if duplicates.none?

    record.errors[attribute] << duplicates_error_message(duplicates)
  end

  def duplicates_error_message(duplicates)
    "has duplicates: #{duplicates.join(', ')}"
  end
end
