# frozen_string_literal: true

require 'active_model' unless defined?(ActiveModel)

require 'generators/rails/form_generator' if defined?(Rails::Generators)

require 'lite/form/version'
require 'lite/form/helpers/propagation'
require 'lite/form/helpers/persistence'
require 'lite/form/helpers/errors'
require 'lite/form/exceptions'
require 'lite/form/states'
require 'lite/form/base'
