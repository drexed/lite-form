# frozen_string_literal: true

module Lite
  module Form
    module Helpers
      module Persistance

        def persisted?
          false
        end

        def create
          raise Lite::Form::NotImplementedError unless defined?(create_action)

          run_callbacks(:create) { create_action }
        end

        def save
          raise Lite::Form::NotImplementedError unless defined?(save_action)

          run_callbacks(:save) { save_action }
        end

        def update
          raise Lite::Form::NotImplementedError unless defined?(update_action)

          run_callbacks(:update) { update_action }
        end

      end
    end
  end
end
