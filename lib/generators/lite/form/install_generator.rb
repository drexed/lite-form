# frozen_string_literal: true

require 'rails/generators'

module Lite
  module Form
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../templates', __FILE__)

      def copy_application_query_file
        copy_file('install.rb', 'app/forms/application_form.rb')
      end

    end
  end
end
