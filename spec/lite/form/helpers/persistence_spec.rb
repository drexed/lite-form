# frozen_string_literal: true

require 'spec_helper'

class FooPersistenceForm < Lite::Form::Base

  attribute :name, :string
  attribute :age, :integer, default: 18

  attr_accessor :signature

  validates :name, presence: true

  before_create :prepend_signature!
  after_create :append_signature!

  private

  def create_action
    self.name = 'Jane Doe'
  end

  def prepend_signature!
    self.signature = "Prefix #{name}"
  end

  def append_signature!
    self.signature = "#{signature} Suffix"
  end

end

RSpec.describe Lite::Form::Helpers::Persistence do
  let(:foo) { FooPersistenceForm.new(params) }

  let(:params) do
    { name: 'John Doe' }
  end

  describe '#persistence' do
    context 'when testing setup' do
      it 'to be an Lite::Form::NotImplementedError error' do
        expect { foo.save }.to raise_error(Lite::Form::NotImplementedError)
        expect { FooPersistenceForm.save }.to raise_error(Lite::Form::NotImplementedError)
      end
    end

    context 'when testing actions' do
      it 'to be "Jane Doe" for instance object' do
        foo.create

        expect(foo.name).to eq('Jane Doe')
      end

      it 'to be "Jane Doe" for class object' do
        foo = FooPersistenceForm.create(params)

        expect(foo.name).to eq('Jane Doe')
      end
    end

    context 'when testing validations' do
      it 'to be false' do
        foo.name = nil
        foo.create

        expect(foo.errors.empty?).to eq(false)
      end
    end

    context 'when testing callbacks' do
      it 'to be "Prefix John Doe Suffix"' do
        foo.create

        expect(foo.signature).to eq('Prefix John Doe Suffix')
      end
    end
  end

end
