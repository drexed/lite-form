# frozen_string_literal: true

module Lite
  module Form
    module Helpers
      module Errors

        module ClassMethods

          def perform(action, params = {})
            klass = %w[create update].include?(action.to_s) ? send(action, params) : send(action)

            if klass.success?
              yield(klass.result, Lite::Form::Success, Lite::Form::Failure)
            else
              yield(klass.result, Lite::Form::Failure, Lite::Form::Success)
            end
          end

        end

        class << self

          def included(klass)
            klass.extend(ClassMethods)
          end

        end

        def errored?
          !success?
        end

        def merge_errors!(klass, direction: :from)
          case direction
          when :from then errors.merge!(klass.errors)
          when :to then klass.errors.merge!(errors)
          end

          nil
        end

        def merge_exception!(exception, key: :internal)
          errors.add(key, "#{exception.class} - #{exception.message}")

          nil
        end

        def success?
          errors.empty?
        end

      end
    end
  end
end
