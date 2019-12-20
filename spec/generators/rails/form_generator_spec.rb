# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Rails::FormGenerator, type: :generator do
  destination(File.expand_path('../../tmp', __FILE__))

  before do
    prepare_destination
    run_generator(%w[v1/users/age])
  end

  let(:form_path) { 'spec/generators/tmp/app/forms/v1/users/age_form.rb' }

  describe '#generator' do
    context 'when generating app files' do
      it 'to be true when form file exists' do
        expect(File.exist?(form_path)).to eq(true)
      end

      it 'to include the proper markup' do
        form_file = File.read(form_path)
        text_snippet = 'class V1::Users::AgeForm < Lite::Form::Base'

        expect(form_file.include?(text_snippet)).to eq(true)
      end
    end
  end

end
