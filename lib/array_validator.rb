require 'active_model'
require 'active_support/i18n'
I18n.load_path += Dir[File.dirname(__FILE__) + "/locale/*.yml"]

class ArrayValidator < ActiveModel::EachValidator
  I18N_SCOPE = 'activerecord.errors.messages.array'.freeze

  def validate_each(record, attribute, values)
    unless values.is_a? Array
      record.errors[attribute] << (options[:message] || 'is not an array')
      return
    end

    check_subset(record, attribute, values) if options[:subset_of].present?
    check_format(record, attribute, values) if options[:format].present?
    check_duplicates(record, attribute, values) if options[:duplicates] == false
    check_if_sorted(record, attribute, values) if options[:sorted].present?
  end

  private

  def check_subset(record, attribute, values)
    unlisted_values = values - options[:subset_of]
    return if unlisted_values.empty?

    record.errors[attribute] << subset_error_message(unlisted_values)
  end

  def subset_error_message(unlisted_values)
    I18n.t('subset_of', scope: I18N_SCOPE, invalid_values: unlisted_values.join(', '))
  end

  def check_format(record, attribute, values)
    invalid_values = values.select { |value| value !~ options[:format] }
    return if invalid_values.empty?

    record.errors[attribute] << format_error_message(invalid_values)
  end

  def format_error_message(invalid_values)
    I18n.t('format', scope: I18N_SCOPE, invalid_values: invalid_values.join(', '))
  end

  def check_duplicates(record, attribute, values)
    duplicates = values.select { |value| values.count(value) > 1 }.uniq
    return if duplicates.none?

    record.errors[attribute] << duplicates_error_message(duplicates)
  end

  def duplicates_error_message(duplicates)
    I18n.t('duplicates', scope: I18N_SCOPE, invalid_values: duplicates.join(', '))
  end

  def check_if_sorted(record, attribute, values)
    raise ArgumentError, 'Not a supported sorting option' unless [:asc, :desc].include?(options[:sorted])

    sorted = if options[:sorted] == :asc
               values.sort == values
             else
               values.sort.reverse == values
             end
    return if sorted

    record.errors[attribute] << sorting_error_message(values)
  end

  def sorting_error_message(values)
    I18n.t('sorting', scope: I18N_SCOPE, direction: "#{options[:sorted]}ending")
  end
end
