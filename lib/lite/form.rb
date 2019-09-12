# frozen_string_literal: true

require 'active_model'
require 'lite/form/version'

%w[errors persistance].each do |name|
  require "lite/form/helpers/#{name}"
end

%w[exceptions states base].each do |name|
  require "lite/form/#{name}"
end

require 'generators/lite/form/install_generator'
require 'generators/rails/form_generator'
