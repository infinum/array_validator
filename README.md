# ArrayValidator

[![Build Status](https://travis-ci.org/infinum/array_validator.png)](https://travis-ci.org/infinum/array_validator)
[![Code Climate](https://codeclimate.com/github/infinum/array_validator/badges/gpa.svg)](https://codeclimate.com/github/infinum/array_validator)
[![Test Coverage](https://codeclimate.com/github/infinum/array_validator/badges/coverage.svg)](https://codeclimate.com/github/infinum/array_validator/coverage)

ActiveModel Validations for array attributes (e.g. Postgres JSONB).

## Usage

Validate the content of the array is a subset of a predefined list:

```ruby
class Plant < ActiveRecord::Base
  validates :categories, array: { subset_of: ['trees', 'flowers'] }
end
```

Don't allow duplicates:

```ruby
class Plant < ActiveRecord::Base
  validates :categories, array: { subset_of: ['trees', 'flowers'], duplicates: false }
end
```

Validate each element matches a format:

```ruby
class Plant < ActiveRecord::Base
  HH_MM_REGEX = /(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]/
  validates :watering_times, array: { format: HH_MM_REGEX }
end
```

Validate the elements are ordered:

```ruby
class Plant < ActiveRecord::Base
  validates :intake_times, array: { order: :asc }
  validates :quantities, array: { order: :desc }
end
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'array_validator'
```

And then execute:

    $ bundle


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in the `gemspec`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/infinum/array_validator.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
