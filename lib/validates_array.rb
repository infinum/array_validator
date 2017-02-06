require 'active_model'
require 'active_support/i18n'
require 'validates_array/version'
require 'validates_array/validator'

module ValidatesArray
end

# Compatibility with ActiveModel validates method
# which matches option keys to their validator class
ActiveModel::Validations::ArrayValidator = ValidatesArray::Validator
