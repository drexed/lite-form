# frozen_string_literal: true

module Lite
  module Form
    class Base

      extend ActiveModel::Callbacks
      extend ActiveModel::Naming

      include ActiveModel::Attributes
      include ActiveModel::Dirty
      include ActiveModel::Model
      include ActiveModel::Serialization
      include Lite::Form::Helpers::Errors
      include Lite::Form::Helpers::Persistance

      define_model_callbacks :create
      define_model_callbacks :save
      define_model_callbacks :update

    end
  end
end
