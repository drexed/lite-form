# frozen_string_literal: true

module Lite
  module Form
    module Helpers
      module Persistance

        module ClassMethods

          %i[create save update].each do |method_name|
            define_method(method_name) do |**args|
              klass = new(**args)
              klass.send(method_name)
              klass
            end
          end

        end

        class << self

          def included(klass)
            klass.extend(ClassMethods)
          end

        end

        def persisted?
          false
        end

        def create
          raise Lite::Form::NotImplementedError unless defined?(create_action)
          return unless valid?

          run_callbacks(:create) { @result = create_action }
        end

        def save
          raise Lite::Form::NotImplementedError unless defined?(save_action)
          return unless valid?

          run_callbacks(:save) { @result = save_action }
        end

        def update
          raise Lite::Form::NotImplementedError unless defined?(update_action)
          return unless valid?

          run_callbacks(:update) { @result = update_action }
        end

      end
    end
  end
end
