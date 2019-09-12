# Lite::Form

[![Gem Version](https://badge.fury.io/rb/lite-form.svg)](http://badge.fury.io/rb/lite-form)
[![Build Status](https://travis-ci.org/drexed/lite-form.svg?branch=master)](https://travis-ci.org/drexed/lite-form)

Lite::Form is a library for using the form object pattern to separate business logic
from model from classes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lite-form'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lite-form

## Table of Contents

* [Setup](#setup)
* [Usage](#usage)
* [Forms](#forms)

## Setup

`rails g lite:form:install` will generate the following file:
`../app/forms/application_form.rb`

```ruby
class ApplicationForm < Lite::Form::Base
end
```

Use `rails g form NAME` will generate the following file:
`../app/forms/[name]_form.rb`

You will then need to fill this class with the methods and actions you want to perform:

```ruby
class UserForm < ApplicationForm

  # Setup up your form attributes using active model attributes
  # or PORO attr_*
  attribute :name, :string
  attribute :age, :integer, default: 18

  attr_accessor :signature

  # Setup your form validations like you would on model objects
  validates :name, presence: true

  # Access 4 predefined callbacks to trigger before, after, and
  # around your actions. Available callbacks are `initialize`
  # `create`, `save`, and `update`
  before_create :prepend_signature!
  after_update :append_signature!

  private

  # Action methods are required methods that get executed when
  # you call an active model persistence such as `create`,
  # `save`, and `update`
  def create_action
    # Propagation methods help you perform an action on an object.
    # If successful is returns the result else it adds the object
    # errors to the form object. Available propagation methods are:
    # `create_and_return!(object, params)`, `update_and_return!(object, params)`,
    # `save_and_return!(object)`, and `destroy_and_return!(object)`
    create_and_return!(User, attributes)
  end

  def update_action
    user = User.find(attributes[:id])
    update_and_return!(user, attributes.slice(:id))
  end

  def prepend_signature!
    self.signature = "Prefix #{name}"
  end

  def append_signature!
    self.signature = "#{signature} Suffix"
  end

end
```

## Usage

To access the form you need to pass the object to the form class and thats it.
You can even decorate a collection of objects by passing the collection to `decorate`.

```ruby
form = UserForm.new(params)
form.save #=> UserForm object

# - or -

UserForm.create(params) #=> UserForm object

# - or -

UserForm.perform(:update, params) do |result, success, failure|
  success.call { redirect_to(user_path, notice: "User can be found at: #{result}") }
  failure.call { redirect_to(root_path, notice: "User cannot be found at: #{result}") }
end
```

## Forms

The following mixins are included for you in the form base file so you can use it to setup
your form in any way, shape and form. The forms `model_name` will tried to be inferred from
the form object name, if not it will default back to its class name. There are also 4 most
common callbacks used with forms already setup to be used.

``` ruby
# Default mixins that are included
extend ActiveModel::Callbacks
extend ActiveModel::Naming
extend ActiveModel::Translation

include ActiveModel::Model
include ActiveModel::Attributes
include ActiveModel::Dirty
include ActiveModel::Serialization

# Default callbacks that are defined
define_model_callbacks :initialize
define_model_callbacks :create
define_model_callbacks :save
define_model_callbacks :update
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/lite-form. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Lite::Form project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/lite-form/blob/master/CODE_OF_CONDUCT.md).
