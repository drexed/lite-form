# frozen_string_literal: true

module Lite
  module Form
    module Helpers
      module Propagation

        private

        %i[archive destroy save].each do |action|
          define_method("#{action}_and_return!") do |klass|
            errors.merge!(klass.errors) unless klass.send(action)
            klass
          end
        end

        def create_and_return!(klass, params)
          klass = klass.create(params)
          errors.merge!(klass.errors) unless klass
          klass
        end

        def update_and_return!(klass, params)
          errors.merge!(klass.errors) unless klass.update(params)
          klass
        end

      end
    end
  end
end
