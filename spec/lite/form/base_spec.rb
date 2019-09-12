# frozen_string_literal: true

require 'spec_helper'

class FooBaseForm < Lite::Form::Base; end

class UserForm < Lite::Form::Base

  attr_accessor :signature

  after_initialize :assign_signature!

  private

  def assign_signature!
    self.signature = 'Unknown'
  end

end

RSpec.describe Lite::Form::Base do

  describe '.model_name' do
    it 'to be "FooBaseForm"' do
      expect(FooBaseForm.model_name.name).to eq('FooBaseForm')
    end

    it 'to be "User"' do
      expect(UserForm.model_name.name).to eq('User')
    end
  end

  describe '.initialize' do
    it 'to be "Unknown"' do
      form = UserForm.new

      expect(form.signature).to eq('Unknown')
    end
  end

end
