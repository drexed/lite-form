# frozen_string_literal: true

require 'spec_helper'

class FooErrorsForm < Lite::Form::Base

  attribute :name, :string
  attribute :age, :integer, default: 18

  validates :name, presence: true

  private

  def create_action
    123
  end

end

RSpec.describe Lite::Form::Helpers::Errors do
  let(:foo) { FooErrorsForm.new(params) }
  let(:bar) { FooErrorsForm.new(params) }

  let(:params) do
    { name: 'John Doe' }
  end

  describe '.perform_create' do
    it 'to be success yield results' do
      s1 = 'success'
      s2 = 'failure'

      FooErrorsForm.perform(:create, params) do |result, success, failure|
        expect(result).to eq(123)
        expect(success.call { s1 }).to eq(s1)
        expect(failure.call { s2 }).to eq(nil)
      end
    end
  end

  describe '.errored?' do
    it 'to be false' do
      expect(foo.errored?).to eq(false)
    end

    it 'to be true' do
      foo.errors.add(:name)

      expect(foo.errored?).to eq(true)
    end
  end

  describe '.merge_errors!' do
    it 'to be merged errors in :from direction' do
      bar.errors.add(:field, 'bar error message')
      foo.errors.add(:field, 'foo error message')

      foo.merge_errors!(bar, direction: :from)

      expect(foo.errors.messages).to eq(field: ['foo error message', 'bar error message'])
      expect(bar.errors.messages).to eq(field: ['bar error message'])
    end

    it 'to be merged errors in :to direction' do
      bar.errors.add(:field, 'bar error message')
      foo.errors.add(:field, 'foo error message')

      foo.merge_errors!(bar, direction: :to)

      expect(foo.errors.messages).to eq(field: ['foo error message'])
      expect(bar.errors.messages).to eq(field: ['bar error message', 'foo error message'])
    end
  end

  describe '.merge_exception!' do
    it 'to be internal error message' do
      foo.merge_exception!(ArgumentError.new('sample message...'))

      expect(foo.errors.messages).to eq(internal: ['ArgumentError - sample message...'])
    end
  end

  describe '.success?' do
    it 'to be true' do
      expect(foo.success?).to eq(true)
    end

    it 'to be false' do
      foo.errors.add(:name)

      expect(foo.success?).to eq(false)
    end
  end

end
