# frozen_string_literal: true

require 'active_model' unless defined?(ActiveModel)

require 'generators/rails/form_generator' if defined?(Rails::Generators)

require 'lite/form/version'

%w[propagation persistence errors].each do |name|
  require "lite/form/helpers/#{name}"
end

%w[exceptions states base].each do |name|
  require "lite/form/#{name}"
end
