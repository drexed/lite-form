# frozen_string_literal: true

module Lite
  module Form
    module Helpers
      module Propagation

        private

        def create_and_return!(klass, params)
          klass = klass.create(params)
          merge_errors!(klass) unless klass.errors.empty?
          klass
        end

        def save_and_return!(klass, *args)
          merge_errors!(klass) unless klass.save(*args)
          klass
        end

        def update_and_return!(klass, params)
          merge_errors!(klass) unless klass.update(params)
          klass
        end

      end
    end
  end
end
