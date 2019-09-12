# frozen_string_literal: true

require 'spec_helper'

class FooPropagationForm < Lite::Form::Base

  attribute :name, :string
  attribute :age, :integer, default: 18

  validates :name, presence: true

  private

  def update_action
    user = User.last
    update_and_return!(user, attributes)
  end

end

RSpec.describe Lite::Form::Helpers::Propagation do
  let(:foo) { FooPropagationForm.new(params) }

  let(:params) do
    { name: 'John Doe' }
  end

  before do
    User.create!(name: 'Jane Doe', age: 21)
  end

  describe '#propagation' do
    it 'to be "Baby Doe" when update was successful' do
      foo.name = 'Baby Doe'
      foo.update

      expect(foo.result.name).to eq('Baby Doe')
    end

    it 'to be false when yielding errors from form' do
      foo.name = nil
      foo.update

      expect(foo.errors.empty?).to eq(false)
    end

    it 'to be false when yielding errors from model' do
      foo.age = nil
      foo.update

      expect(foo.errors.empty?).to eq(false)
    end
  end

end
