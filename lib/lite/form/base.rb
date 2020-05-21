# frozen_string_literal: true

module Lite
  module Form
    class Base

      extend ActiveModel::Callbacks
      extend ActiveModel::Naming
      extend ActiveModel::Translation

      include ActiveModel::Model
      include ActiveModel::Attributes
      include ActiveModel::Dirty
      include ActiveModel::Serialization
      include Lite::Form::Helpers::Errors
      include Lite::Form::Helpers::Persistence
      include Lite::Form::Helpers::Propagation

      define_model_callbacks :initialize
      define_model_callbacks :commit
      define_model_callbacks :create
      define_model_callbacks :rollback
      define_model_callbacks :save
      define_model_callbacks :update

      attr_reader :result

      def initialize(params = {})
        run_callbacks(:initialize) { super(params) }
      end

      class << self

        def model_name
          klass = name.gsub('Form', '')
          klass = Object.const_get(klass)
          klass.model_name
        rescue StandardError
          super
        end

      end

    end
  end
end
